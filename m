Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EA1C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 08:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409D010E095;
	Wed, 19 Mar 2025 08:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GbDe9quV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B92D10E095
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 08:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA4X5rko1084GMtIYvAnlS0jNzBgiA96scBjkcsIiSzX+BXH1mZ/+dPzOd25fZgyIX4vUIZQjNuZFnxaxprkGt0prhPYxWo3E9S7lHuihlvxHaszuBCN/9c8LwPai5QanzB/EcrbMQhLQBQkBPRKiS2CPEEaw4WB4+CDl06UqyZ838OJYS22J2wusi0K3Q0eXtw7m71mSY+xPq75XgCKOy4zeyyNUYlz3KZvz8hg5skbskUDvMbD252ltbo9gt2hlsQVmuQvfu5GFacEdWwkta/rETDbyu3cPJkSP4oipraW6hUvcgPQRIxPwGTNpssuVPmxuuyFovd6KQT9zs/zCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOYX/Vg70b/MvN+p9zmppLraQ8+2ZBJd4nZyTq4WJsg=;
 b=O4hF5TsHR4S6XxCrspNE3A/LoT7euOPDGWrF0lt9Wc/7zjMG99nHCd7nmzwE8b7gf7xBwnrLOxjVSh1655fvwkgTJ0FQZI/Hg18ndAe6x0k4DzDxDlWEoyaE+JaVCwupnsO9U6bYt+gZs2MieswARto6q3Gu5mtx3NyrhHMZPznSeapo2tu3ZJr6J4W/sJSZ87yjuxQtCfcdg+gDp7UrvakFXdx5QwGj4+6utGlBLUuveJ+0AxoG7d13BwkZp/cEMuE2i28mP1d3gKvV3k9aXdtR0yCh3X0BrzW2S301xEinnv9qjYK4iMDAwA/0i0VCm/zzI016COIkQ+M7RVdGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOYX/Vg70b/MvN+p9zmppLraQ8+2ZBJd4nZyTq4WJsg=;
 b=GbDe9quVuxYRHkCl+WaVC1oHvpUYpSR+qsqlRuJ04AJ3U0+tuAUXQBig0mL8hpHAQdYDyTiOXIs89r/rA2Il53C1Z8gEL1mrRNb0HbJJXuFiWrtWd/NfAVyo3g5yVXnjcXVQLm9WLwi42Eqc1n20taBbtob95mKN0QZxuKQ55nI=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 08:33:57 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%5]) with mapi id 15.20.8534.027; Wed, 19 Mar 2025
 08:33:57 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix display freezing issue when resizing apps
Thread-Topic: [PATCH] drm/amdgpu: Fix display freezing issue when resizing apps
Thread-Index: AQHbmBW1AxjDvV/enEyyJo5b3ScWMLN6IvpT
Date: Wed, 19 Mar 2025 08:33:57 +0000
Message-ID: <MW4PR12MB5667CC801BEAA355955D7047F2D92@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20250318145431.28944-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250318145431.28944-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T08:33:57.576Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|MW6PR12MB8661:EE_
x-ms-office365-filtering-correlation-id: b11ba8aa-4e0f-407c-98e9-08dd66c0caba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QLzdcWef7/fyGSPa1txMggLieED+lbpt++nAwzI0iPPLY/COVjcAQs1Qyf?=
 =?iso-8859-1?Q?imYWpdxb0LodFA/h4C4SAxsQ8ABIwTgwiW9xhLUfu7hPqYgxeNNiRG36mR?=
 =?iso-8859-1?Q?eqqnmU/kE5Il+o2+oZ1ymfNvmTldkJxtI5SmNphZg3L0a6IyWE+CNWddHI?=
 =?iso-8859-1?Q?fX53UMgYxg0qIRpcHDLQKJJuDOK+mYMFFBJk3iXruO6GWh3cy9g1U/Hl7/?=
 =?iso-8859-1?Q?JvBQyu/DOsynghOHIiAOFRLdGDao+vYLotKpxJ8kBMrEFO2ncqEMgNlVAW?=
 =?iso-8859-1?Q?xNNCEgTv5/s0oMmrc9qU70KTNn69M9bXxWzPes5Caq97DGB8ivWDSnVLOY?=
 =?iso-8859-1?Q?MOhgevvJs4s1/pEc+JqElzsFnU5Klm3j3pCdn6M8XojPY2mVFcHo4IE28k?=
 =?iso-8859-1?Q?ZvyIFe+Z0C/QcoLbDmBQBILaJDjdQrYOHvJBYZPOVvEYA9STNjLDmhjeYc?=
 =?iso-8859-1?Q?yIQ9ItS3WHdesrdXqi8npD4+LWkhKEmIzsYktgCohid6JyGQ4Ouys6tNZo?=
 =?iso-8859-1?Q?QXzbcYNLEZEVVEwS7C+B1ylIOEJsGElOPt1a0ykEMiVIVsFPce/hyESVon?=
 =?iso-8859-1?Q?sKvcF8DiZPp40HjbetgOXPDP/Mx61S9Xb5I0beGz6J0OqeZ/6X3hC2oQ09?=
 =?iso-8859-1?Q?W2rpSQ2Plu1qtbnePD9ElI6XknwtDzY8uN8tKq4RAGsiI2OxNtn2lrBqks?=
 =?iso-8859-1?Q?d42OY3DQ+KETvum6/4FypKJS2qNpL9+QWOLbeEfW6OCFYIgOELYRmviCFp?=
 =?iso-8859-1?Q?LeV7YTZz1duyrMpiXXhkM3SDFOv5V3LJV2HiUl6LJEiLR4LazANwJU8TN+?=
 =?iso-8859-1?Q?hIM3Wm9EoNHW/zdOXxMuV7gZei2ybjgtkIKbh+D+7lRaAz2jZ6mjjyDuSC?=
 =?iso-8859-1?Q?mZ+sEhGQ46FNrWUAwjy5zqtyLyUKoCIf7hXgR4NAmqtbcwZ678qea4rbTP?=
 =?iso-8859-1?Q?Gf0d6UWUoX402yd6S8MQhfkZnED2KfZNNdAMASnl0Jm9cB6bQZzpOn9wTy?=
 =?iso-8859-1?Q?ap9HPTwPB/48ujL/3Ul/lSLTmtDotecwyTEyahx9ixIgFNn8A202L+2wbM?=
 =?iso-8859-1?Q?FWQYn+xgNAlMvTd+wykdndhWtSjrO0qlfpBXglwxcoMQfVWixLqe6BQNBR?=
 =?iso-8859-1?Q?wwBd68KQWXIq8siUp4nIZlmS9v7Yzs2lyJfmG6uQR1Wn/fGYNl2Cva00Oe?=
 =?iso-8859-1?Q?eh4lTnUGLpN+5A/mFyRyfuFQiwcAxy8Nki4bKwjsOwa6uyxNTEqPPuPblX?=
 =?iso-8859-1?Q?DRf/hhY6xKjomhSLPftNz7V0dPQWoK9KpvV7ZuVVyI3DRVTsx0FRzeIRqG?=
 =?iso-8859-1?Q?h+lkLeyJMzZwtW70Non1ZbBwt7Vo/CIgaAY/Xh17TWJOjXMzdGyLQinymM?=
 =?iso-8859-1?Q?QiF2Ntare0ZT3VtAwgqs9OLaSin84krOwH9Hc/QSRKp6VN1rm5jY018uvb?=
 =?iso-8859-1?Q?sEdLYrIpQbliJvBPNN+mHLiI0OoTrcUKRjIIzqIi7umdQa2mBT4pCeIz6h?=
 =?iso-8859-1?Q?qRfXjszR8gPXWlplK0GyNk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?amc+I52EQYILj0JP7F7QSj7raKsZRP01Vyozl2WePiTdL+fZfHstNQntgg?=
 =?iso-8859-1?Q?d5VB68N1NuWagUWewysib2O/VSL4htUqJnwk2oaC8kSYkhsjS/LUUHssNF?=
 =?iso-8859-1?Q?N9MQJjsi6veIqtXeUptFYe5RyjcY8IhQUERz0mXBK13CQARnuOotf4IaUh?=
 =?iso-8859-1?Q?oE6sljpRUWanaLFrrlNKAyvESNrac74jMKnN7MqFQUzOGQtXO+Y2nj1Xc/?=
 =?iso-8859-1?Q?zMhYF7ehP3sCax3SAvxj94PvdZVmF87pZv+oa9s3ePmA+EQqiKsVvnY//9?=
 =?iso-8859-1?Q?/wtTvYRKorL87oWQ76+MfYmGFpDlqqI/Sygkg7P3kqdVNJhxs7+xQDys6p?=
 =?iso-8859-1?Q?D7NTIG2gsKOEJk6GV0vvRcPNKQaEhNjSPBGNyqVPFvcw7z1+LvzLMUd8TY?=
 =?iso-8859-1?Q?Gu1qy0j5otNUbxJ+3U4HjMPtTSezHfeI+254iiBGwpmr0EVA65LGZhzSwt?=
 =?iso-8859-1?Q?Xwz4v6PFG5uyj0Df8gakFqeB5Fuf0YrHaW8eQ40EmVxtODanNdeF16YB1E?=
 =?iso-8859-1?Q?PAFS5L9x02DA5mTCV3PuXZxJMAI3ejCPG91OyBRPUsNL8E8n98F52FXMLV?=
 =?iso-8859-1?Q?gce4LFarcnqzuXxy4WGasaDR/OJDJUlfZ4jrXruiRdMrlcMVH/NgCe//OW?=
 =?iso-8859-1?Q?H/BJdmzfF4p+mi9GFMa7Dg83Jumso5f6deEIPPlNQ9Q92HhAygMJKz8TtW?=
 =?iso-8859-1?Q?7x1UzUnJu0aOInwHMwmqozaFJLYnRezmilWB3/j46n+DYk8VsCl3BFuoSp?=
 =?iso-8859-1?Q?1u5owq8WXzZxqh4Bbp4RawySA0F9fxtFNLyQiyy8sve9VZq9iyehVHRCDJ?=
 =?iso-8859-1?Q?A10j/oSgNiOIi0iJTH7eIG/MK5EVSGNK4/S38OcdOJTi+7GAe80XYofpWB?=
 =?iso-8859-1?Q?KU32hanCUiC1TMmPD6bIkksxz8LTm/oHe06s6e2RrVR6sx2if2TADf8vNt?=
 =?iso-8859-1?Q?HM0HBMvhGfzI9T5NeM5SFWzM+w7YuuANOnblDLM4wEFrb8RmRtOWlNggL1?=
 =?iso-8859-1?Q?g+j+8uWEhRzupZJuQLch1hAafMkiMymMBxrykiHhdg40T1M/bYZlxZ6ilR?=
 =?iso-8859-1?Q?5cVrWreoCzgEuryX5ZPrv1/cFmwWJP/E8SOHYq64suGkNvoRND4i3F5bV2?=
 =?iso-8859-1?Q?eq82fFUQTubLi8+puTSx50yb/V0HLNOmFxeD7yRhtA+vJW7wmb2do4yFU6?=
 =?iso-8859-1?Q?6+L+kqOd/Mp0ZepujDncgTSLT932dn8Va1I2n9jsdwYmWjeUuhtlsFC09s?=
 =?iso-8859-1?Q?Mq67KXpNZtQB8LdYjEJUDfs2MHp6/XH71/nOWBa8Oh/rm9qq4oq10rlx6o?=
 =?iso-8859-1?Q?bRRG6Y/nL09z4flNNx5BMvFWTXDBL0vsi5HqenmUAusSqB0iQmGiD/VFw2?=
 =?iso-8859-1?Q?hsh4I8JrHR9cU96QtfXuqyBZUY6079moRJ8jSsHkuA769iPA0bcHO/UiYL?=
 =?iso-8859-1?Q?Fo4/Yj4PEwUAVELDr28P52I6mK0p/KPRP4Gy6SwBRqmnGdrMdVRnTgLZg7?=
 =?iso-8859-1?Q?UCGz62b+l2MMjG3V5s8R5tyoFA6jiwr3sH915Z6qIX9wipv852m+NEMYWF?=
 =?iso-8859-1?Q?H3AXVvT7uN8dFlT3wWigkpggE9fn5St08Usl2N2fmy9RTTlGVN5PzRGOi/?=
 =?iso-8859-1?Q?ptP93D0PFBgOY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB5667CC801BEAA355955D7047F2D92MW4PR12MB5667namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11ba8aa-4e0f-407c-98e9-08dd66c0caba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 08:33:57.7077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiXP9j81TO9FdGvstfQDjV6nh5ff9yyTkvFhdqYczhu1AIVhKv6NZShIoYqlWvKFYyUfTpxi37GXfSGi6zuUrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

--_000_MW4PR12MB5667CC801BEAA355955D7047F2D92MW4PR12MB5667namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

Regards
Shashank
________________________________
From: Yadav, Arvind
Sent: Tuesday, March 18, 2025 3:54 PM
To: Koenig, Christian; Deucher, Alexander; Khatri, Sunil; Sharma, Shashank
Cc: amd-gfx@lists.freedesktop.org; Yadav, Arvind; Koenig, Christian; Yadav,=
 Arvind
Subject: [PATCH] drm/amdgpu: Fix display freezing issue when resizing apps

The display is freezing because the amdgpu_userq_wait_ioctl()
is waiting for a non-user queue fence(specifically, the PT update fence).

RootCause:
The resume_work is initiated by both amdgpu_userq_suspend and
amdgpu_userqueue_ensure_ev_fence at same time. The amdgpu_userq_suspend
signals a dma-fence and subsequently triggers the resume_work, which is
intended to replace the existing fence by creating new dma-fence. However,
following this, the amdgpu_userqueue_ensure_ev_fence schedules another
resume_work that generates a new dma-fence, thereby replacing the one
created by amdgpu_userq_suspend. Consequently, the original fence will
never be signaled.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 167951aee502..0075469550b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -52,6 +52,9 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_evictio=
n_fence_mgr *evf_mgr,
         unsigned long index;
         int ret;

+       if (evf_mgr->ev_fence &&
+           !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
+               return 0;
         /*
          * Steps to replace eviction fence:
          * * lock all objects in exec (caller)
--
2.34.1


--_000_MW4PR12MB5667CC801BEAA355955D7047F2D92MW4PR12MB5667namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shashank</div>
<hr style=3D"display: inline-block; width: 98%;">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Yadav, Arvind<br>
<b>Sent:</b>&nbsp;Tuesday, March 18, 2025 3:54 PM<br>
<b>To:</b>&nbsp;Koenig, Christian; Deucher, Alexander; Khatri, Sunil; Sharm=
a, Shashank<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org; Yadav, Arvind; Koenig, Chris=
tian; Yadav, Arvind<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu: Fix display freezing issue when re=
sizing apps
</span>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">The display is fre=
ezing because the amdgpu_userq_wait_ioctl()<br>
is waiting for a non-user queue fence(specifically, the PT update fence).<b=
r>
<br>
RootCause:<br>
The resume_work is initiated by both amdgpu_userq_suspend and<br>
amdgpu_userqueue_ensure_ev_fence at same time. The amdgpu_userq_suspend<br>
signals a dma-fence and subsequently triggers the resume_work, which is<br>
intended to replace the existing fence by creating new dma-fence. However,<=
br>
following this, the amdgpu_userqueue_ensure_ev_fence schedules another<br>
resume_work that generates a new dma-fence, thereby replacing the one<br>
created by amdgpu_userq_suspend. Consequently, the original fence will<br>
never be signaled.<br>
<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
Cc: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
Signed-off-by: Arvind Yadav &lt;arvind.yadav@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_eviction_fence.c<br>
index 167951aee502..0075469550b0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c<br>
@@ -52,6 +52,9 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_evictio=
n_fence_mgr *evf_mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (evf_mgr-&gt;ev_fence &amp;&amp;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !dma_fence_is=
_signaled(&amp;evf_mgr-&gt;ev_fence-&gt;base))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Steps to replace e=
viction fence:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * * lock all objects=
 in exec (caller)<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB5667CC801BEAA355955D7047F2D92MW4PR12MB5667namp_--
