Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA7CCA47F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 14:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A032B18AA7A;
	Thu,  7 Jul 2022 14:39:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF82E18AA7D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 14:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLDAAKsdzucppcLRsNalEvlWwTLqxXV5T/Vf4IYN0FL0l9xzZ/PAlDyHDYOj5yXy6ZqcNzyOQF+PbAO9W2m1hntHoCc0rBsSZ40jt63SnNae+79KGpj2WJIDfCLAZ3o8YbdPOoinZIOYUlR/LpJ4Ey+stwM7mVbKvCEhK9YMNQUiVax3e1cQli33mFStSCV2xWH1TSq7IVv7a4GXrt7+nUfM+O1v+QvZwOhYSt8MrGAlUeA2RNVtK+6S38m9PmHncu8KT4bgFMWzxu/pzIAvmetzI5eJDA0ZGaEyw9sl5Mi6f111ic4w8tTRd6rwdNY95N7EuXpRntkGgV3RzvJLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08p+CCrZwP8e4K3LVbB3NBsKDsz0BRMnNs+QxgxeuKY=;
 b=ihQE9V3iI9zjslAUldOKlxnBwDjMOrgD22tTRTcCyPn/DzzKHFPDHc2K4deeeu/zMmQc9cG5p9VnQq7MP09Kcy0g7HMEpTUKD5kmALBiCNSpVV4Z5UsEC8xjFq8my9C4qRPg6VBV55+UQpZh8STDDany+9XYkQDHnpNZhv52U/abJqSde2ANTYvAHN7QIj3UEV6MZ7emdm17ARwgFm4ccxsfg7dI98AHNXnhtbb8QQm58ARawK9nlIrPQ3O3V/se4xHimrdnpLTYR+WJ9SYBtYLaYuHW4UOETLIL9ZVfSbH1fmCbXr/d8g/0JV1xvbI2arplIuKTif7CnjOya8XkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08p+CCrZwP8e4K3LVbB3NBsKDsz0BRMnNs+QxgxeuKY=;
 b=qDbn6KThmc0xnzebWCVLyUyGABXVzutLBwZfqDFIcvJPdvjSqf9+z34FC2SZOdk8gyuJYXPqerPNdPsUhzAoxziCrWRbbXJb0sQeA2X9lwxjY8oHT80nYjEex7ssEagule/CqyGNwIJEOwicjUbLDzdKZL6Gt5om1r9do7ZvqjY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 14:39:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 14:39:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
Thread-Topic: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
Thread-Index: AQHYkg21aL9xi7uSek+p9B27d0LASK1y+nhe
Date: Thu, 7 Jul 2022 14:39:17 +0000
Message-ID: <BL1PR12MB514425128FB9A4D3402864A5F7839@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220707142727.3250944-1-kenneth.feng@amd.com>
In-Reply-To: <20220707142727.3250944-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T14:39:17.418Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8dd20c-0496-43b7-a9c4-08da602678d6
x-ms-traffictypediagnostic: MN0PR12MB6221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qsm3g7WCq3F5iNqbqFkfvpQBx1zxunp6wDAq2mRk+s+GoHx/Ouuv4cQS21c5FKysyZLZRyIQzEQpoDfE+cwJWhTVhn9yKC6TJMVliFlpr3/WfIph+qhGf2/gKVgN9doNHjIl5l9ejOS894RskgXpXfas3C7B0VpQFGxGh12Q/jMe2UsDcT1ItiivMNCX14HXZ01pQYOYuPD7ZJRfBLBbHPyAWyJaqBv923Q4jf6nq95RAwVF9WilAcoUxnP64rbwEgdDqe49ouTLSiTinKcImNwW2KwZur9WN1kjcdamblClZ/u2JdpTmRcPW1S1GEhC95KKe0MDB1mK0GI+cXyYHXfNQhlayCURJtIX8GgZxogHyqakQSBK8MGqc4Z5AWeMlXjriyTdHl+Gapd3Xd1iy2ThX+K4Yy62mYIIt0OaQnWpPcvmbJNqYfX+Pp1hTThbUffLsq85AE75ZYSqmMJLF2InJzlZRrLTiKbI2gIB0Xnf2ytRSBR1LkVm56aFSBas2LT1y3bQJ6fBxPpSOCip+B2enXI36LFU9oJ8lR64lU/ze3SFnjarxd/6whcvVpjTGQk0bjmEwTi725++f6sXPt6spHF7iU9fQiTIpVls3VB9HtC0fMSBe4PJMR9+a8P1VUDYRkwygDE1g8H2j8L/1uwxY0nzT5UI1f+flFxaVrs6Zn3dNvVECtqXAkc+eE9vmWlhvXJ32gcSiDRkWCeEGgX0JyUCL7WslVWKLuQQbZa3aU4o5Z8hnBTH3JRyFP3LgtzlR5eSDdwn1GYr/h0LJZ/0qR/BdurqqtHGGCnjQwPbi1sWpRcGFslJFZfcpYY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(19627405001)(38070700005)(186003)(64756008)(6506007)(110136005)(41300700001)(7696005)(71200400001)(83380400001)(55016003)(26005)(122000001)(53546011)(316002)(66446008)(38100700002)(8676002)(2906002)(9686003)(52536014)(8936002)(5660300002)(86362001)(76116006)(478600001)(66556008)(66946007)(66476007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sgb3SXOw1XJaT2wNTAYPXgeLLhslxNDKh6yr9BTfLLdr8n9IGzGg6SdAlIxB?=
 =?us-ascii?Q?tGjItsW0pJYd2uwKwx9oOLd2F6yP7n8eKzW4B7T/0skJckybAgAwXkS2WHfh?=
 =?us-ascii?Q?myNfLX/FI+oMzRswqzRxnItpDmUIsK94LPqWbX6XkhZz9GRjSJHOIRi7oqlj?=
 =?us-ascii?Q?3ejs+4gh/71a1yWuNhy5gxMJn0C14u3qKKRf0MDem7Ubxnb0rEKGY8T5K0I3?=
 =?us-ascii?Q?5KL125ZfJMoV2L6rl6Ci0bGQvP8cEJh4Flp/WfNhvemdMPR7N/S2LTN1sT0f?=
 =?us-ascii?Q?xoqwP7WYfyInV39VbUqJyKqMx6XafR16ZHjXxd+C1ZnU/L5MV2iLtc7zdiID?=
 =?us-ascii?Q?1fDFUoDzP6S3mKWUA/lef/5f9t4svarDWhjTfaZMWdkx1tA9Qnbs/+5dMGCg?=
 =?us-ascii?Q?UqocqxoqJ2ZrhvBk/SjO3Ucj4PjtZqfpc/6KTrFYKs1RIu07UnbmU3qmkPHv?=
 =?us-ascii?Q?EoVB9ndmW1tLyk1bMB21lzzbvS3JKoZK3lTJOtdQ0+fB++Uz60zct3MU8VKd?=
 =?us-ascii?Q?7cHxL1XGjUlONkdgHZ0OcjzVA3AHpLWVXA9L5ZL93k3NWCZArF7BmCE8p0d2?=
 =?us-ascii?Q?VFUdB9inL65yzxgQ9Rj4IDjiNFNofXEgkERUV8EMVTlD6j3tItBs0drVHyIU?=
 =?us-ascii?Q?XJBcxvunf5VZ9Bjcf86JYVmvvv7pcsnsi93yCtaDo9hwx24I67+Zisj7a6oY?=
 =?us-ascii?Q?vZoylh7I0iRDC514WdecYa9972hEV09iVaf/CCaMR94td8duG3JAoRgz4w6c?=
 =?us-ascii?Q?o1Fn1UvbjzTx4LoUS4AwNs7yit35jPfeRB1vro/OkVfgWSi92qyb8ylbfGif?=
 =?us-ascii?Q?xZNIR3EI+0R3ZYs9dwkHw9Wrr3ELU/nTRTwKNn6TOpgeZSmS2AF/cJUlZQ+c?=
 =?us-ascii?Q?uwZejGQrVbtcKweXInCb9oo6g/FkzM73dWNdg4vPQRTtd+AFDp0MxqnIyU7L?=
 =?us-ascii?Q?nkXfqNn7vrVjetHB6UhCihNQhI6cwS4oyHDriwTBo3w0o9AXKhPoJe2OflbH?=
 =?us-ascii?Q?edvb4REEBVfbsisG/yF7kmOj724e3vHTwOq5geXF2+0GeG/73aArlNSfbQJV?=
 =?us-ascii?Q?UwC6YNj+zzWqzFICB6qRA76uaQwHV8HUjJ1PbHTxws3k0Mw5o3t9VlyYFtyv?=
 =?us-ascii?Q?BxrkucUEk3euMP2WTp0l47/vDT2GKM9OLsW714tlnXfFkrHhlZJXFKDVmyWX?=
 =?us-ascii?Q?QIFIyAkVh5Jecwu2js33RIJqx4QHH3XcN6bAC+dqK6d/oFSsQz/AeVMLcAYV?=
 =?us-ascii?Q?Ib+v4+rY0kZypdRiUIqqh+vqrXiDzJ91cAnDRQ/99scN1C2SOoEAEfWurvwL?=
 =?us-ascii?Q?ieaP8AC8ySoq0dY1XYu923pmjeKBARQHnW4+5W1GF8vDh59u4wQntXfJ9OYH?=
 =?us-ascii?Q?ebAE9/k2yznWpgriMXklJHj7mgGb89LtLcaw+D49eW5h70L7uiSUoUT5QNov?=
 =?us-ascii?Q?kvr0bLCDuAHFwUrhnU39UcNwTZke83NGT52zEVMstF4/dOxYRBL9wGhgxmOK?=
 =?us-ascii?Q?FsYdAh9iM6lw5uA+BRyIzeKiQ3ko42M0eUA4uo91Y9Iq5gUzg2csnETurl5k?=
 =?us-ascii?Q?jLGPGo1/LOfrhHhyTlg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514425128FB9A4D3402864A5F7839BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8dd20c-0496-43b7-a9c4-08da602678d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 14:39:17.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kuEYN6TvSO2DNqEI/dJ49+lS7QGDaIsoocgCvNrANmfCsIx9CsU68dso5QXz0Wy6PxAFJNjwSJsTtihCi/8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
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

--_000_BL1PR12MB514425128FB9A4D3402864A5F7839BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Thursday, July 7, 2022 10:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0

fixed the issue: gpu runs in dc mode but it is expected to be in ac mode.
this causes the lower performance on smu_v13_0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |  9 ++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 28 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 ++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
index 3f2d0a9e4745..6aaefca9b595 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
@@ -128,7 +128,12 @@
 #define PPSMC_MSG_EnableAudioStutterWA           0x44
 #define PPSMC_MSG_PowerUpUmsch                   0x45
 #define PPSMC_MSG_PowerDownUmsch                 0x46
-#define PPSMC_Message_Count                      0x4C
-
+#define PPSMC_MSG_SetDcsArch                     0x47
+#define PPSMC_MSG_TriggerVFFLR                   0x48
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x49
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
+#define PPSMC_MSG_SetPriorityDeltaGain           0x4B
+#define PPSMC_MSG_AllowIHHostInterrupt           0x4C
+#define PPSMC_Message_Count                      0x4D

 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index a1cb8e73e171..19084a4fcb2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -74,6 +74,7 @@
        __SMU_DUMMY_MAP(OverDriveSetPercentage),       \
        __SMU_DUMMY_MAP(SetMinDeepSleepDcefclk),       \
        __SMU_DUMMY_MAP(ReenableAcDcInterrupt),        \
+       __SMU_DUMMY_MAP(AllowIHHostInterrupt),        \
        __SMU_DUMMY_MAP(NotifyPowerSource),            \
        __SMU_DUMMY_MAP(SetUclkFastSwitch),            \
        __SMU_DUMMY_MAP(SetUclkDownHyst),              \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0e59ab2192bf..0328bc12ca21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1084,9 +1084,35 @@ int smu_v13_0_set_power_limit(struct smu_context *sm=
u,
         return 0;
 }

+static int smu_v13_0_allow_ih_interrupt(struct smu_context *smu)
+{
+       return smu_cmn_send_smc_msg(smu,
+                                   SMU_MSG_AllowIHHostInterrupt,
+                                   NULL);
+}
+
+static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
+{
+       int ret =3D 0;
+
+       if (smu->dc_controlled_by_gpio &&
+           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+               ret =3D smu_v13_0_allow_ih_interrupt(smu);
+
+       return ret;
+}
+
 int smu_v13_0_enable_thermal_alert(struct smu_context *smu)
 {
-       return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+       int ret =3D 0;
+
+       if (smu->smu_table.thermal_controller_type) {
+               ret =3D amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+               if (ret)
+                       return ret;
+       }
+
+       return smu_v13_0_process_pending_interrupt(smu);
 }

 int smu_v13_0_disable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 193222fdd1c4..6259a85bc818 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -111,6 +111,8 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D
         MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,  =
             0),
         MSG_MAP(GetDcModeMaxDpmFreq,            PPSMC_MSG_GetDcModeMaxDpmF=
req,         1),
         MSG_MAP(OverridePcieParameters,         PPSMC_MSG_OverridePciePara=
meters,      0),
+       MSG_MAP(ReenableAcDcInterrupt,          PPSMC_MSG_ReenableAcDcInter=
rupt,       0),
+       MSG_MAP(AllowIHHostInterrupt,           PPSMC_MSG_AllowIHHostInterr=
upt,       0),
         MSG_MAP(DramLogSetDramAddrHigh,         PPSMC_MSG_DramLogSetDramAd=
drHigh,      0),
         MSG_MAP(DramLogSetDramAddrLow,          PPSMC_MSG_DramLogSetDramAd=
drLow,       0),
         MSG_MAP(DramLogSetDramSize,             PPSMC_MSG_DramLogSetDramSi=
ze,          0),
--
2.25.1


--_000_BL1PR12MB514425128FB9A4D3402864A5F7839BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 7, 2022 10:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: ac/dc change for smu_v13_0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">fixed the issue: gpu runs in dc mode but it is exp=
ected to be in ac mode.<br>
this causes the lower performance on smu_v13_0<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;.../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h&nbsp; |&nbsp; 9 ++++--<b=
r>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; |&nbsp; 1 +<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 28 +++=
+++++++++++++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp; |&nbsp; 2 ++<br>
&nbsp;4 files changed, 37 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h<br>
index 3f2d0a9e4745..6aaefca9b595 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h<br>
@@ -128,7 +128,12 @@<br>
&nbsp;#define PPSMC_MSG_EnableAudioStutterWA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x44<br>
&nbsp;#define PPSMC_MSG_PowerUpUmsch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x45<=
br>
&nbsp;#define PPSMC_MSG_PowerDownUmsch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x46<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x4C<br>
-<br>
+#define PPSMC_MSG_SetDcsArch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x47<br>
+#define PPSMC_MSG_TriggerVFFLR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x48<br>
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired&nbsp;&nbsp;&nbsp; 0x49<br>
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A<br>
+#define PPSMC_MSG_SetPriorityDeltaGain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x4B<br>
+#define PPSMC_MSG_AllowIHHostInterrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x4C<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x4D<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h<br>
index a1cb8e73e171..19084a4fcb2b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
@@ -74,6 +74,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(OverDriveSetPerc=
entage),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetMinDeepSleepD=
cefclk),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ReenableAcDcInte=
rrupt),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowIHHostInterrupt)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(NotifyPowerSourc=
e),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetUclkFastSwitc=
h),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetUclkDownHyst)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 0e59ab2192bf..0328bc12ca21 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -1084,9 +1084,35 @@ int smu_v13_0_set_power_limit(struct smu_context *sm=
u,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int smu_v13_0_allow_ih_interrupt(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_AllowIHHost=
Interrupt,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
+}<br>
+<br>
+static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;dc_controlled_by_gpio &am=
p;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_featu=
re_is_enabled(smu, SMU_FEATURE_ACDC_BIT))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_v13_0_allow_ih_interrupt(smu);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;int smu_v13_0_enable_thermal_alert(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_get(smu-&gt;adev, &=
amp;smu-&gt;irq_source, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smu_table.thermal_control=
ler_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_irq_get(smu-&gt;adev, &amp;smu-&gt;irq_source, 0)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v13_0_process_pending_inte=
rrupt(smu);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v13_0_disable_thermal_alert(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 193222fdd1c4..6259a85bc818 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -111,6 +111,8 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownJpeg,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownJpeg,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDcModeMaxDpmFre=
q,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_GetDcModeMaxDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(OverridePcieParame=
ters,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_OverridePci=
eParameters,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ReenableAcDcInterrupt,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ReenableAcDcInter=
rupt,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowIHHostInterrupt,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowIHHostI=
nterrupt,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetD=
ramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddr=
Low,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLo=
gSetDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramSize=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
PSMC_MSG_DramLogSetDramSize,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0),<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514425128FB9A4D3402864A5F7839BL1PR12MB5144namp_--
