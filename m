Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ECC10A88E2
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 16:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E6210E1BD;
	Thu, 26 Mar 2026 16:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0Y5YZf6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C82D10E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9jyR3EZV82Ry/5cqmgMsQvxHcQxxOKyb3GDCcALHkJA8YXTf75BWDHQ3YC9r1xtVpQ2lUyyB8+5yb3EeGxwEW7HUse0cCokA8Q/VL5bzJ5f5iSVRQVLN8w6N+5A6sPQvelbOEyzohX/c9w09WOkZ/zC7IRJo/FRCMEnqomNsL0MczQx2Xrweo81SKUJv7dYrEPlxoBbHbJEedrEarEm/uY/Rp1uRkl7jEs+xYZD9Np+R9G06lQ3yItarqYDqkpiGLuX9ESn21r7UmqF76niblNCOyihni8DL+czcsg6aM1+ZVYiT6TJLPRlEnLfgdmCvHJ+itv/CJnZp+MXMRQQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UksOEsZhyT/zwBp2V8shX/paBJjHs24FW7D/qaCOylk=;
 b=NRxPSlbGy5ibg8T2fjNbqrM4FrHTqT4FelEmS3/mfaLrzYtUs+SH/rfiN7t2VkBPzGSifspP8b/C1X2A9sRaeG1Nq1R4x8U0zaIITxPQitDKisADvPoeOpC5/uOYyi1phJG58DadcbhnCw7zRCHo32kgn1n072Aw+54lE8uXDQa3As+cM/r5WOLN7bqQTFtfUAZZEmVQ3pk/qrwTNy74RuGt3v9iZLU5+SX9wBflNUc7EvHkGCwGQnnCUrBLDOy3obPyPIYBnZBSGDt6hx62J8RC+NGyOHhoaa8hERxkqqnk/86d/Vwwd3CCsUtW6S1RswfqDogh89ElyqhX/BFilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UksOEsZhyT/zwBp2V8shX/paBJjHs24FW7D/qaCOylk=;
 b=l0Y5YZf6F53PV4+CXGwO0FI4j3P4qGvuYKBBBNq39rG6GYDmlgq4wfiiHooU0CaqjoqxdvvwtMOWBr9ACf1KxCQCv8zCy2PS+DHF7CqqlV1iyy0+l1mkdTOtz8irl+Ym8RbcNfSanz+AMogcaFrpR8aT7hHU25saSPoEtOKPaGE=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 16:06:27 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 16:06:27 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "alexdeucher@gmail.com"
 <alexdeucher@gmail.com>
CC: "Chen, Michael" <Michael.Chen@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
Thread-Topic: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
Thread-Index: AQHcu7e8aMZolSSenU6bNxFblgf5cLXA+6kQ
Date: Thu, 26 Mar 2026 16:06:26 +0000
Message-ID: <CH0PR12MB5372EC4D6256F14210FBC59DF456A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-10-Amber.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-26T15:59:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|BL3PR12MB6548:EE_
x-ms-office365-filtering-correlation-id: 156d4919-bbf9-4c10-abbf-08de8b51a284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ZWmf6MeXwwsXyEoirbCvulMe5918M+IjiBa1Vs9zI+9xMNrSNEnBAlRb5ywqHIajBSAeoNjsf/Z3zsHavT8QW9C/jrfr02WS+iHc5Pw4dJYYSOS3TXAAIiFlLuYhCsafIGbiecuB2V5XmKjiK3R5fpKeBh6TwlMU0C1En6q3X64pHmVZr+ZrJFFTlUaBtiCqrD5brh2VqgQXJGuBKnRzD/BkOy+3CZ4FZHaTaygShiwRS7MsVDhaH6KX71wkNcKbMzCRBsXgzKzSxpFWjIcr7n3ZBPhZZu5dpcBtVhIh7sMjwCqPsfkfSsNY4bCQUSLbhQwhLDgEhdsvbpCGEx3DBoN2QmfSpr9FmgWQ5wto25tObNLiZpCmQ+eaWwrwkXDWfGRKXLjiw3T5jW30UvE6BuebSpqFLqkxg4zrzeu3YXIxDh8Wg8tjHJrltGKe2j8rEZAb2J6AM6KhcMNFk7TfSVTeButSvuhRT0c8IFUUAQFtf8upHnkCOhL0TahU3bigXJmK3iobZ1Ate8nG0yeb3v6JFgihjDXQGmrhElsNG70/beRsFXt8OWQDB1i1APS0YmoNSLFSsJoRDBNSpRaY0ecaKceFB2GjBbEPNVW1FtMik9/sRAu4PPPVYZ8rdOLoE609b4WWtI+zWiTs/skqv1nfzEnVcQt7RsRhFaCUKaO0LXQwjTfy1O89kFnrX3d7OMLcJMZQ3Uh8O5JWAeFvqjOLrqRtupGHrxS2ewoV9AzkIHkXaWiixfejZGsQItyx5JbAF+P3ZeGUfvn74UTXyOOJ5lWm0cfFgNAm7G1AGbY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40Q3YPGbRcA3xbZYgMp0boZ6T1jzM70OD1AbDeNlRKXPphDHJcHie2wdpi5v?=
 =?us-ascii?Q?b3cBnaFzt96UeqSHXtacy4Q07EeA/dmHCRlOD9oZ7mYAT7DzIlUn4zwTy+/v?=
 =?us-ascii?Q?HpCqfBYJScWjbSWApmdD8eoXgwxAYxZOsAQ0MHmjygCPwqX4gNgxGj2gPB15?=
 =?us-ascii?Q?xW2UR6/Tre1ywTbe+CYDP6P54JaE/deUsdXavGW+YI02NXN041XFXpIHGkIB?=
 =?us-ascii?Q?P/VdjpN4dtz/RjcCNKIHMUhmooVnCEL7s+MZyhnpRYQqBj4eLv/Xegi8QZaz?=
 =?us-ascii?Q?Sl4ZyiYiQIvWrJsuwmqvYU24AP2iOhkFFTU/mRfev2pwHhD+YxYV7zHx8btS?=
 =?us-ascii?Q?l8yvUks8oZ7v/Q37OyEOPedKBaaejvQt7u6UNkJj0A3KwdbnedvWHmDPquAI?=
 =?us-ascii?Q?RvVChm2LemAJ1CFjtgtadck5Vy9j8T7W4TXL8X76XKMfrZAHZ3LGQSqCGx2q?=
 =?us-ascii?Q?r9Mkq9+316g3FygVxE5+qShp8unGqHU3yq1M72jCqvu0U31S68Dy10ZCwHvL?=
 =?us-ascii?Q?8Ov+WD3b7RVMbuIGIlj+QgPhLUWY6q9cOss0YQcT1zU+WvzfuQzXhPHOaNpy?=
 =?us-ascii?Q?0fcksuitGFXZoJcOO1qlMlfETlbdW3G3Hn0uDP00UqfKOVTmNW9KK6ll6OZe?=
 =?us-ascii?Q?LzL5XQDOeDKzKVp/0uVjphIMxTjh/7oVA0PPzRhOSCBB0gNJfck862PbzMmv?=
 =?us-ascii?Q?QvuJEhBOalgKballpTVy0hsVe03a4mKhHfluQ+/bKG3bVwllKwKXRyCUzYVv?=
 =?us-ascii?Q?Uhgu/5mY0d1sQ3+fHDqHPoMRxiIgbaXWj0WR31HYBPlR5aCrS6xuj+NG8zLn?=
 =?us-ascii?Q?CRcp1rZc/VVZmMbddbyGqUISf24W67RHqFR7UbBg7jDR/yvs58ChuvIyFKXL?=
 =?us-ascii?Q?CpF3qKHbDv/7fj6i836UzClONrlu1yrMmCZE8+v4N78mVdHZr1basLkq9knC?=
 =?us-ascii?Q?UToTX30/xfuWXvEmZgobJ1HlDp31q+L6ibM+SW6uKkWP+D151Fsy6JqB998g?=
 =?us-ascii?Q?PqfndbvhVcmtivxglW3Ly3ljCa+HeGXUpM5ayI8MMpSqC9cUBTqo8DcpdIHJ?=
 =?us-ascii?Q?o/3Fn22e3VBvrOWdoYjl8s/0HmSN+YRwAk6Y4pdJ8s2DIHaS0+AgcXHIJ7zO?=
 =?us-ascii?Q?RdMXUrpAL8iCi5jUVGEhT7ifWkuJBLyNyBoZj7kO2F9VydgSpFn6TncUMSXZ?=
 =?us-ascii?Q?dvDkBRul5R6Z5jueIOVOwJ2jAW64uMpsu/dmNHiXGtjGBf/Q8mmN+a7L5RtO?=
 =?us-ascii?Q?IXEuVJ3EsTFBE+oEKOUxVZ1cKVS1P/mlk8cnuYiqU3999Dy95AxZThWktlyX?=
 =?us-ascii?Q?Oh22m/6opCP3C15DOB3xiSdxeRzI470HmoH0aCgzT3G/C+/2oimplSEBp9Ce?=
 =?us-ascii?Q?eETmxHjmw5blUeG9Qb5kppkHmMLZLnv9tDihK4/VRYcRojcmJixECKQoRGaw?=
 =?us-ascii?Q?S32hehRRr+L/2CaqyAFsEK5O/65ey50G37bMgWUwxZASp3q5j/ZM0c9Yi4eB?=
 =?us-ascii?Q?Szk6RmAMILXBX+k+gOwgy4BTGFo12sstyoAZPiOXeEH/2B/se0tRwhIVoxj2?=
 =?us-ascii?Q?Y1K+PjW/yv5SrwnJPDrC2PpNlwwFyl7PEtWhDPj3RjvyEhXSnZG3ZvdpZ0bF?=
 =?us-ascii?Q?O55xFPDBaOUxmsgsfmekgwvFvt9TE5MRrh60zu6ZfiZrAT8R92Rt+Tnyzvrr?=
 =?us-ascii?Q?updL4ewG3hqPPC+i8OlK6zM6lJMcS9tWAiFe11IKUPzlqugF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156d4919-bbf9-4c10-abbf-08de8b51a284
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 16:06:26.8356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjQzxYgRgUL7xTcbq+UrbfisvD76Rh40sRDaHcdG4ANKtnhwO82iLgWDvRYYYU/SBIYHV6+xUTNJSjJFlGK/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Maybe  I missed something , can you explain a little bit more on how driver=
 will do the cleanup on those hung queues in the failed list after the rese=
t & detect call ? will driver call remove_queue on each of them and  notify=
 user ? If the hung queue is KCQ ,will driver create a new KCQ ?

Regards
Shaoyun.liu

-----Original Message-----
From: Lin, Amber <Amber.Lin@amd.com>
Sent: Tuesday, March 24, 2026 1:57 PM
To: amd-gfx@lists.freedesktop.org; alexdeucher@gmail.com
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chen, Michael <Michael.Chen@amd.com=
>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Lin, Amber <Amber.Lin@amd.com>;=
 Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES

When removing queues fails, KFD calls amdgpu_mes to detect and reset hung q=
ueues, then cleans up those hung queues in KFD.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index f3a4ae1fd521..7cf4b3d6fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct am=
dgpu_device *adev)
                amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 0, =
0));  }

+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
+*adev) {
+       return (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 1=
, 0) &&
+               (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x=
73); }
+
 /* Fix me -- node_id is used to identify the correct MES instances in the =
future */  static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device=
 *adev,
                                            uint32_t node_id, bool enable) =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 643b4f8d757a..44fa4d73bce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes =
*mes)  }

 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device
+*adev);

 int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ec8d7f4be840..1c9c350bfffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manag=
er *dqm,
                                struct queue *q, const uint32_t *restore_sd=
ma_id);

 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool=
 is_sdma);
+static int resume_all_queues_mes(struct device_queue_manager *dqm);
+static int suspend_all_queues_mes(struct device_queue_manager *dqm);
+static struct queue *find_queue_by_doorbell_offset(struct device_queue_man=
ager *dqm,
+                                                  uint32_t doorbell_offset=
);
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct qu=
eue *q,
+                              struct qcm_process_device *qpd);

 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type) @=
@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
        return r;
 }

-static int remove_queue_mes(struct device_queue_manager *dqm, struct queue=
 *q,
-                       struct qcm_process_device *qpd)
+static int remove_queue_mes_on_reset_option(struct device_queue_manager *d=
qm, struct queue *q,
+                                           struct qcm_process_device *qpd,
+                                           bool is_for_reset,
+                                           bool flush_mes_queue)
 {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
        int r;
        struct mes_remove_queue_input queue_input;

+       /* queue was already removed during reset */
+       if (q->properties.is_reset)
+               return 0;
+
        if (!dqm->sched_running || dqm->sched_halt)
                return 0;
        if (!down_read_trylock(&adev->reset_domain->sem))
@@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager=
 *dqm, struct queue *q,
        memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
        queue_input.doorbell_offset =3D q->properties.doorbell_off;
        queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
+       queue_input.remove_queue_after_reset =3D flush_mes_queue;
        queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;

        amdgpu_mes_lock(&adev->mes);
@@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manage=
r *dqm, struct queue *q,
        amdgpu_mes_unlock(&adev->mes);
        up_read(&adev->reset_domain->sem);

+       if (is_for_reset)
+               return r;
+
        if (r) {
+               if (!suspend_all_queues_mes(dqm))
+                       return resume_all_queues_mes(dqm);
+
                dev_err(adev->dev, "failed to remove hardware queue from ME=
S, doorbell=3D0x%x\n",
                        q->properties.doorbell_off);
                dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n"); @@ -305,6 +324,12 @@ static int remove_queue_mes(struc=
t device_queue_manager *dqm, struct queue *q,
        return r;
 }

+static int remove_queue_mes(struct device_queue_manager *dqm, struct queue=
 *q,
+                           struct qcm_process_device *qpd)
+{
+       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);=
 }
+
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)  {
        struct device_process_node *cur;
@@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue=
_manager *dqm)
        return retval;
 }

+static int reset_queues_mes(struct device_queue_manager *dqm) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
+       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
+       int hqd_info_size =3D adev->mes.hung_queue_hqd_info_offset;
+       int num_hung =3D 0, r =3D 0, i, pipe, queue, queue_type;
+       uint32_t *hung_array;
+       struct kfd_process_device *pdd;
+       struct queue *q;
+
+       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
+               r =3D -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       /* reset should be used only in dqm locked queue reset */
+       if (WARN_ON(dqm->detect_hang_count > 0))
+               return 0;
+
+       if (!amdgpu_gpu_recovery) {
+               r =3D -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       hung_array =3D kzalloc(adev->mes.hung_queue_db_array_size * sizeof(=
uint32_t), GFP_KERNEL);
+       if (!hung_array) {
+               r =3D -ENOMEM;
+               goto fail;
+       }
+
+       hqd_info =3D kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_=
queue_hqd_info), GFP_KERNEL);
+       if (!hqd_info) {
+               r =3D -ENOMEM;
+               goto free_hung_array;
+       }
+
+       memset(hqd_info, 0, hqd_info_size * sizeof(struct
+amdgpu_mes_hung_queue_hqd_info));
+
+       /*
+        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
+        * post suspend_all as reset & detect will return all hung queue ty=
pes.
+        *
+        * Passed parameter is for targeting queues not scheduled by MES ad=
d_queue.
+        */
+       r =3D  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TY=
PE_COMPUTE,
+               false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
+
+       if (!num_hung || r) {
+               r =3D -ENOTRECOVERABLE;
+               goto free_hqd_info;
+       }
+
+       /* MES reset resets queue/pipe and cleans up internally  */
+       for (i =3D 0; i < num_hung; i++) {
+               hqd_info[i].bit0_31 =3D hung_array[i + hqd_info_size];
+               pipe =3D hqd_info[i].pipe_index;
+               queue =3D hqd_info[i].queue_index;
+               queue_type =3D hqd_info[i].queue_type;
+
+               if (queue_type !=3D MES_QUEUE_TYPE_COMPUTE &&
+                   queue_type !=3D MES_QUEUE_TYPE_SDMA) {
+                       pr_warn("Unsupported hung queue reset type: %d\n", =
queue_type);
+                       hung_array[i] =3D AMDGPU_MES_INVALID_DB_OFFSET;
+                       continue;
+               }
+
+               q =3D find_queue_by_doorbell_offset(dqm, hung_array[i]);
+               if (!q) {
+                       r =3D -ENOTRECOVERABLE;
+                       goto free_hqd_info;
+               }
+
+               pdd =3D kfd_get_process_device_data(q->device, q->process);
+               if (!pdd) {
+                       r =3D -ENODEV;
+                       goto free_hqd_info;
+               }
+
+               pr_warn("Hang detected doorbell %x pipe %d queue %d type %d=
\n",
+                               hung_array[i], pipe, queue, queue_type);
+               /* Proceed remove_queue with reset=3Dtrue */
+               remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, f=
alse);
+               set_queue_as_reset(dqm, q, &pdd->qpd);
+       }
+
+       dqm->detect_hang_count =3D num_hung;
+       kfd_signal_reset_event(dqm->dev);
+
+free_hqd_info:
+       kfree(hqd_info);
+free_hung_array:
+       kfree(hung_array);
+fail:
+       dqm->detect_hang_count =3D 0;
+       return r;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev; @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_que=
ue_manager *dqm)
        up_read(&adev->reset_domain->sem);

        if (r) {
+               if (!reset_queues_mes(dqm))
+                       return 0;
+
                dev_err(adev->dev, "failed to suspend gangs from MES\n");
                dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n");
                kfd_hws_hang(dqm);
@@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_ma=
nager *dqm, struct queue *q
                q->properties.queue_id, pdd->process->lead_thread->pid);

        pdd->has_reset_queue =3D true;
+       q->properties.is_reset =3D true;
        if (q->properties.is_active) {
                q->properties.is_active =3D false;
                decrement_queue_count(dqm, qpd, q);
@@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct de=
vice_queue_manager *dqm, uin
        return NULL;
 }

+static struct queue *find_queue_by_doorbell_offset(struct
+device_queue_manager *dqm, uint32_t doorbell_offset) {
+       struct device_process_node *cur;
+       struct qcm_process_device *qpd;
+       struct queue *q;
+
+       list_for_each_entry(cur, &dqm->queues, list) {
+               qpd =3D cur->qpd;
+               list_for_each_entry(q, &qpd->queues_list, list) {
+                       if (doorbell_offset =3D=3D q->properties.doorbell_o=
ff)
+                               return q;
+               }
+       }
+
+       return NULL;
+}
+
 static int reset_hung_queues(struct device_queue_manager *dqm)  {
        int r =3D 0, reset_count =3D 0, i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 27e4859e4ad7..6cb33f6d71e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -523,6 +523,7 @@ struct queue_properties {
        uint32_t pm4_target_xcc;
        bool is_dbg_wa;
        bool is_user_cu_masked;
+       bool is_reset;
        /* Not relevant for user mode queues in cp scheduling */
        unsigned int vmid;
        /* Relevant only for sdma queues*/
--
2.43.0

