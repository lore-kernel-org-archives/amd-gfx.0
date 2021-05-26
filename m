Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4475C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DEB6109E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DEB6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4EE6EC7A;
	Wed, 26 May 2021 11:00:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8E36EC7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 11:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT0Cg9FzDrbmfxy6UIfB1Qy2v5s3xWvZLbQRYOexlAF0HKciALSpJtm+Ej+W6eUEzBPBLMtpqrWAF+uQXba02EbZvtim5XiWvyAyLpOvbTKNRBwN9Y0ETCSZh3Xk/Z2GqAK1v3jkvFWoOLL6jNS9IEK3tKSqn2X3REWmv4nOvOr3hBuXpA7DO5K1xXK+1qxz2niKdQ4/325VWLRRtQBUWT3iUCJg4Gc+d7eUKCZtLxWlZ5v/J/VzsQ8bGvKGHEVPi8eKyEH05tARtQ4ZRd8ipw20U084R57qLpEciqUzmZd1gT7h7a47kOC+uRR5ULtJtrNtTSkKNtqZiu7h030jzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MF88r2167lXNNm26fLcyLU5AQXNOW+UQnngy/nRoa0=;
 b=Z1yY71zP3Lrekx7xcH9G7IzIaTA9HRFrR1UaDenSgEXeINU+UPhOuJ9vPDtcXnIoDLvjn3rKyB6XbonhzbNHGQhD/lTs8RjRiV2Jyqos5v/rpOG1rS2wIFW/7J7lesj9KB6Ostt8iz+prSQlLZ6LUCaNm2bD6rqk0ubhpV2fFSN5wvY1u3rO7XQ8IV2ccNSUeC/yvIFEOUwk+fpkrSMG8Bad6Iv5Z1Ck/2ir8Hs652HMWPxHxqrWkKggbEFvgQdXA2ceSBzEjuCSX+HDp62Ms+eMRRXA0JvPEd2nK/tvbWTes9JVFFBii55dHhId/nDp/PeRC0n3YZu5+tjkUYTdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MF88r2167lXNNm26fLcyLU5AQXNOW+UQnngy/nRoa0=;
 b=J112+TyQwLX0o/NeXeiP1POphZnb2xYafg3XTPxbdDcoLDa+bJSzazHKel4V0/Cx2zQJOwWPOBVAsP6JyNKs+qH4ird5sdFNgANH/L4XgH2JO9fdzCQvIZmRG3M4QPqnQu/6LkfXg9W+oH5e/1LzzaNWG4z13a97DAnJ3LbM/Z0=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 11:00:53 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 11:00:53 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Topic: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Index: AQHXTobuj88Hu0lpuEKN0hDwuL++Nqr1ns2A
Date: Wed, 26 May 2021 11:00:52 +0000
Message-ID: <CH0PR12MB53487EE4BD75A8B5493F742D97249@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210521211836.4839-1-luben.tuikov@amd.com>
 <20210521211836.4839-3-luben.tuikov@amd.com>
In-Reply-To: <20210521211836.4839-3-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T11:00:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3fca01d7-6e25-4415-9b56-9d2872424b87;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.144.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e042eaf6-ccf7-41b2-0f7e-08d9203587b6
x-ms-traffictypediagnostic: CH0PR12MB5137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB51376C88C66B35BCCA2735B997249@CH0PR12MB5137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzsCkeOaBGgKdFgxersFqQmVNPba8X8cjPiI9ECJx/WLUNQFLlYE7M/FdRNbmKZg6HKugXg0M+sXgCvSiWsrYfosXuMhyZNyRuqDZQRreAzLgYOkOOf4bhjFn0bM9Z3gKZ3L8D80tJnVunml/sOPPzhroyX1WxQgis7/qqA6MdLLcniCcQyUGyLvKmZS0QIbfQrhwQbJkWAiUtCyhcFrN6+370FoRz8IwLIn4pYouNO493+1hyhyFItOPzcN+1xivANDUkDdCQl7azeP1XQDR5beqQUpa5rZaR5GL2dHfv5LPbIS0T3Rj1rc0mS/O+bM4c4pnN9vYOrvx5N6AcoZ3kS/j6nMcrN1r2MkSilicuYa+dlmHCS3b3g7ifEkFDGcQ3Im7brdsYJqtFJJXvMcdWSCMB20XNNAFJPyunYNfa+ylnyz0IJ/yltgchOFPbj3r2OciK3ua5qdq9FKW2tbIlZW64PugxW+JVelUQVYsIjMpNmMkGeSoSI0PXL3Wr2kaMe63OT/HUO4gSJIcJ/pnPvVbwQBsNHCjHFQX/w/Ceb6LONsUTAnVcz8FB0KjLHdK8aPlZBms/W0QFYK4323AlgpcavzwcNnSbIIeKZmjJNTSmMPxoTec4TrrcsAI1Ph4RAujjEjL+1WUGa6JcggiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(110136005)(54906003)(316002)(186003)(76116006)(66946007)(8936002)(64756008)(55016002)(26005)(4326008)(66446008)(66574015)(38100700002)(7696005)(2906002)(66476007)(9686003)(122000001)(53546011)(52536014)(5660300002)(8676002)(6506007)(66556008)(86362001)(71200400001)(83380400001)(45080400002)(33656002)(966005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?TQ1iWO9e82llZfHehK6t4kTCOHTWBpjDCIluZ6dzgArO8hZwff5TMwhyVt?=
 =?iso-8859-1?Q?Blw3O/6JErMsinbVsZ7b54YhoJKJd5wBKEQY9/5xB0UK8+ADieHNeAxsvC?=
 =?iso-8859-1?Q?GhcsBQsHT/3kwCJX3I9ADP+gX+3oamtVY8ZmHUBIVGtTWmH1XlrOBh5JfC?=
 =?iso-8859-1?Q?EPjxXCePp/hdyoSs5t4HloAwfb85fgxiXPya8LfI2+UBoPJYzPQGwtzMMk?=
 =?iso-8859-1?Q?bHlN1+TNrVxeDoIxnaNOpDqDhUAOFND3gwV4tVTgjlHcIFk+xWdM/j6VRy?=
 =?iso-8859-1?Q?+zMpP6O5qXMLD2AztrUEg9IK7WobNle+rku05JcWeHcstEGM8h852/ZG2a?=
 =?iso-8859-1?Q?IOs/HJH8KCArnX7VGnWwqJmgPUJJlqscM3lgV9qcJnaqxiNeuWioU7kbPT?=
 =?iso-8859-1?Q?xF9fVSz6HODmPRlr9PKISzWF6krmOYewGNxrUh0et27MWJx/QvQWfHmTHx?=
 =?iso-8859-1?Q?bYDnfE+DF41T3tRZM9pxKDjsaUN0lMP8g66ojuhjNjI/TQctuZjjhE9rXO?=
 =?iso-8859-1?Q?MpBJq5WB4BLuxL5ywtJSIfQLh7kuS1UZNWvQkLHQM/EQaH4kamxKtzCs6b?=
 =?iso-8859-1?Q?54gLFZXWtRbHLDDV+nrQvcTJdLp99OOsdWA/HnGgEcudK2Tb3bm+VCxrZm?=
 =?iso-8859-1?Q?+DmGOMO4AApssOiZcsjAF+uZamoXZWXlrwOGLbzVWQg2EWBHGc8R7y4hZD?=
 =?iso-8859-1?Q?WS9zmPZjHs7EcMYzrtMyIB4+jO+MEuc4mxcSIIj96OQHBmeAJYwxvUzAx4?=
 =?iso-8859-1?Q?gIFAOAfpWa0pZg282azazSfA2tBR0fCXU91I54cWOnwb7MZphlKPf+P3z3?=
 =?iso-8859-1?Q?wj4nh91Yv5hKurQgZ6n7z7tCqvX6abzcVwQv38y4RC+p9DXyptpEdhigFl?=
 =?iso-8859-1?Q?PKtm8LkXRsUXUuF7N7GlJAtSJE9IU6oH9elfsD2egngv8w1aosPgnar931?=
 =?iso-8859-1?Q?BJWD2bWMXzh9B3rSSTKw3Y4E6WAPf5KVRveC4QxnNrx0z75Y/9wELeeT+U?=
 =?iso-8859-1?Q?sV+TCn+mALx/V2JtBB+76fIE3fz07PduUCG6PA5CggWsE/9QAS509A+hGj?=
 =?iso-8859-1?Q?AMPaqURg/j866KuLo8w5ADpeX/fhatregjzzcK9vqtFBLqBC07821fjMC2?=
 =?iso-8859-1?Q?pLPQBrKOc0CGF9ay8Q6xmWOZabeYHVxwdV69rgjjqRiWL4W2gfyelN3AqB?=
 =?iso-8859-1?Q?KuD0FNaXLvF1V5BTo8AHMww5II5NtJb9tS5C/sR6Ux2hug4XYX0arohPik?=
 =?iso-8859-1?Q?LmPjD3rsPEscUHScdTTktegfygaV8/jiXlaLiiwb8iDl9Bp3fD/xASElaU?=
 =?iso-8859-1?Q?HV+/3mUspjOyDHkCNLY/+7rM5SKShd0+9HW1KXV9nmkHpd5TxW3u3sbG4W?=
 =?iso-8859-1?Q?2KYVOrywLN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e042eaf6-ccf7-41b2-0f7e-08d9203587b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 11:00:52.9995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kT8pQSavbtzIeYUxhLNxP+rO/eiYvQBDyOfLdfYzzHYnyr8w2VjtCnR5pjN9kkVl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Scheduling an error status query just based on IOCTL doesn't sound like a s=
ound approach. What if driver needs to handle errors based on that - for ex=
: if the number of correctable errors exceed a certain threshold?

IMO, I'm more aligned to Luben's original approach of having something wait=
ing in the background - instead of a periodic timer based trigger, it could=
 be an event based trigger.  Event may be an ioctl, error handler timer tic=
ks or something else.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben Tu=
ikov
Sent: Saturday, May 22, 2021 2:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tu=
ikov@amd.com>; Clements, John <John.Clements@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error coun=
ters

On Context Query2 IOCTL return the correctable and uncorrectable errors in =
O(1) fashion, from cached values, and schedule a delayed work function to c=
alculate and cache them for the next such IOCTL.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++--  driver=
s/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++++  drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index bb0cfe871aba..4e95d255960b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -331,10 +331,13 @@ static int amdgpu_ctx_query(struct amdgpu_device *ade=
v,
 	return 0;
 }
 =

+#define AMDGPU_RAS_COUNTE_DELAY_MS 3000
+
 static int amdgpu_ctx_query2(struct amdgpu_device *adev,
-	struct amdgpu_fpriv *fpriv, uint32_t id,
-	union drm_amdgpu_ctx_out *out)
+			     struct amdgpu_fpriv *fpriv, uint32_t id,
+			     union drm_amdgpu_ctx_out *out)
 {
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
 =

@@ -361,6 +364,31 @@ static int amdgpu_ctx_query2(struct amdgpu_device *ade=
v,
 	if (atomic_read(&ctx->guilty))
 		out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 =

+	if (adev->ras_enabled && con) {
+		/* Return the cached values in O(1),
+		 * and schedule delayed work to cache
+		 * new vaues.
+		 */
+		int ce_count, ue_count;
+
+		ce_count =3D atomic_read(&con->ras_ce_count);
+		ue_count =3D atomic_read(&con->ras_ue_count);
+
+		if (ce_count !=3D ctx->ras_counter_ce) {
+			ctx->ras_counter_ce =3D ce_count;
+			out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
+		}
+
+		if (ue_count !=3D ctx->ras_counter_ue) {
+			ctx->ras_counter_ue =3D ue_count;
+			out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
+		}
+
+		if (!delayed_work_pending(&con->ras_counte_delay_work))
+			schedule_delayed_work(&con->ras_counte_delay_work,
+				  msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
+	}
+
 	mutex_unlock(&mgr->lock);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ed3c43e8b0b5..80f576098318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 #include <linux/reboot.h>
 #include <linux/syscalls.h>
+#include <linux/pm_runtime.h>
 =

 #include "amdgpu.h"
 #include "amdgpu_ras.h"
@@ -2116,6 +2117,30 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
 		adev->ras_hw_enabled & amdgpu_ras_mask;  }
 =

+static void amdgpu_ras_counte_dw(struct work_struct *work) {
+	struct amdgpu_ras *con =3D container_of(work, struct amdgpu_ras,
+					      ras_counte_delay_work.work);
+	struct amdgpu_device *adev =3D con->adev;
+	struct drm_device *dev =3D &adev->ddev;
+	unsigned long ce_count, ue_count;
+	int res;
+
+	res =3D pm_runtime_get_sync(dev->dev);
+	if (res < 0)
+		goto Out;
+
+	/* Cache new values.
+	 */
+	amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
+	atomic_set(&con->ras_ce_count, ce_count);
+	atomic_set(&con->ras_ue_count, ue_count);
+
+	pm_runtime_mark_last_busy(dev->dev);
+Out:
+	pm_runtime_put_autosuspend(dev->dev);
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -2130,6 +2155=
,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (!con)
 		return -ENOMEM;
 =

+	con->adev =3D adev;
+	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
+	atomic_set(&con->ras_ce_count, 0);
+	atomic_set(&con->ras_ue_count, 0);
+
 	con->objs =3D (struct ras_manager *)(con + 1);
 =

 	amdgpu_ras_set_context(adev, con);
@@ -2233,6 +2263,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_fs_if *fs_info,
 			 struct ras_ih_if *ih_info)
 {
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	unsigned long ue_count, ce_count;
 	int r;
 =

 	/* disable RAS feature per IP block if it is not supported */ @@ -2273,6 =
+2305,12 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	if (r)
 		goto sysfs;
 =

+	/* Those are the cached values at init.
+	 */
+	amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
+	atomic_set(&con->ras_ce_count, ce_count);
+	atomic_set(&con->ras_ue_count, ue_count);
+
 	return 0;
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block); diff --git a/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 10fca0393106..256cea5d34f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -340,6 +340,11 @@ struct amdgpu_ras {
 =

 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
+
+	/* RAS count errors delayed work */
+	struct delayed_work ras_counte_delay_work;
+	atomic_t ras_ue_count;
+	atomic_t ras_ce_count;
 };
 =

 struct ras_fs_data {
--
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7C3686015f68f84c9088ab08d91c9e0fcf%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637572287465788021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DHbd=
tryTNLwzF862vg6E%2BwKBHmrw8NFz3gKQsU9ggdOk%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
