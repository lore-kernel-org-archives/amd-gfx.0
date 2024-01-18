Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E3C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 13:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC9E10E817;
	Thu, 18 Jan 2024 13:15:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D3110E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 13:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+l1YFZkDGtmV5+c95eiVmlU8yBX8mzOJpIcSWRHr9M9GBtGRgHaNcS6M76XXMGDG6KJ+ZijDgfSI7aDURj/uQ8HCu8OtHSSuf4hX+R0CAb2tGPADTs6Gu0bDgr59EsS2D06ukpUYe3iGkfqiIn0XJoVpwudYzp+qBsR3CNoeGRMr/EIsGVtZIExsQ2yB1440pkptaRoUXqbZYgVVXs0wav425U+yGG/B8nayNjPQr3UAaAeP9kHsV4NXHQsjGZ2JuNy8oncwHqPqv0zKGIZ2Kzx+AgwXUdIihmjarOFgohexumJjr5d2+EySbUK5ZMeA5d7b0cOooT3KbhXSplTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXXK1y+z4QRn8iV/0+hkNUlxFOPWTKh0e2fXd5hbTrM=;
 b=Tj12LjbFCM5ZWofcS57nlNggh3ThR/66Ip4Qu155E4bGdrjCGhpH6CWymLXm0Lnk3ViZ5C1uqtbPMHdz/4qGamkCzccp/WviND1Ma/YzZDqAY2p5oAuxf8ZTFE0XmB3STfH8GKPlgJE/4f1nXbiErybLF8sQISyxNPSvWHD/YzSh/MtOe591V+BPn982z11LnyrVBSzyOgJoZFwfpq3axaX3RDsQCzUiQctngsx93y8VyEjMUWdwbIuDK4xzDXw5KkNEDWXy+o9JconO2hm1ksNpeX094T2fnUZhaQDMvQu+7oxredejZIJmsypAP6pXbliR8UVKnLpyt4usVuykHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXXK1y+z4QRn8iV/0+hkNUlxFOPWTKh0e2fXd5hbTrM=;
 b=VknhKzvG1AWwajqLZz2kOONIXnuALJz1dGNR1NvfgYVErWnhPIoMEzpPOWBt6rDWsLKtgTRLOepV/RsH/BQVfzqpUuS4vlwczs9kRnNXN2aPtYnCwOLwS0sCZC3mfY552uoLnCM8w5XpahPnw1pWvNoX1oAO0jlREYuwyet7WsQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 13:15:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7181.029; Thu, 18 Jan 2024
 13:15:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Topic: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSdmr4Ica6Srkfk+Kq1jkhMhPIrDfjEn4
Date: Thu, 18 Jan 2024 13:15:06 +0000
Message-ID: <PH7PR12MB5997A1FFBF28D64279710E1582712@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T13:12:31.1432102Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB7504:EE_
x-ms-office365-filtering-correlation-id: d165847a-9744-49b1-3ee9-08dc18277d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7gQzJ8zP3BUnQ2vpBNEUynwH5UbdJXoYWKcDCg/637mhPnKVbaSeTcxfIkeUXm3nNpmdo02+sbHekmDLXs7aJyfXgMTnyHnd+Wb2iqXXeEtMA0nGeJMBhYQOM623xozDWP61F0oJcTslB0TpcCFNzTc53/d3I2cAsld4/tBSd1l4U/8iqX4cDsNBGkuYXW9tBY+KpV4wC69t6foHANOJqEyIKozGbUOQeQN0VFh5bb3T80Ect6KGOLrGTcauRhgZMpnEM3XaL3/rDx9SLPekglSplHoXyNXoIpLFNypi+d3BqEFwgFogE1pQ4ZeTkoreeAYZsCCPA9+mzDZt5aFFn/qcGMEfDu7uRalWPOj0iz0biRrGN1Cje8kcNCC9WOB2UQRk6i1Gj194hMaQE9opcnxeg9/ONGEI0f7p8nX6PyhHI7yk/NnruCW38bR9upuOLRGq/KlJG0tS9TxHqH8NPLXniN6zhddacXDWpUrfz1Oo9oAdTjslfb7u3CBiDZ55l4gEU64G9owpXh+LCWiZVNPcuIyxHsqxdwFxAjRLMSlpPAAH6An66YuNlxaFSpLLnUAGIeSvxBMHRT2oJK6sUfaTyTJNzD9IIeMUEP+j+r+UR4HVf1JHBzl+yKNJdhE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(9686003)(6506007)(7696005)(53546011)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(52536014)(2906002)(71200400001)(478600001)(316002)(64756008)(91956017)(54906003)(66476007)(66556008)(66446008)(66946007)(76116006)(110136005)(86362001)(33656002)(38070700009)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koY+9vNU9KrL+WVnYH0ZogXXESxWlQbhVnzzaGlUNXklXAEbLs0C9/PB0nDk?=
 =?us-ascii?Q?3eTQJ2ypAMu4CNO+VPeQ9NlhTCnJGT73T7CX7s0K//169D9L8DpPL8aANhrh?=
 =?us-ascii?Q?gFjLXAfePI25PijSyfXj2FFBoH9iQUZJYmPagzSqZcpqeUr4K256RtPhCWzQ?=
 =?us-ascii?Q?E/vJH5xpShETy75eANYRXE3VsQbdgkKwBBPUyhOnwg0NIzrZQ+Jw/8aJVGL+?=
 =?us-ascii?Q?v+hwOrDQWMgCuK7dzC3xK7IyMpLqnwEFWjquOq41Ox6watsRUdtDKwv+NPZk?=
 =?us-ascii?Q?R+3zBetpmPEg2SGmIksIMdxUeD6yX0nzfCIJiojVWAnKOFMWJnC30MYgXyZ+?=
 =?us-ascii?Q?iEn6J+MWa7PFxrC/vtwRaTcqC4uZg0z88T8mePO79bMTeTzg+B61P9tHj0mm?=
 =?us-ascii?Q?ugC3E4Q/r8dke7RbubLnOntX0ZeVOsrlOslyHEWfdI+9AaBvy0+kdKxQ0OWT?=
 =?us-ascii?Q?L1d9FlrZdzUK/x+1ExoBP1+WIxI9sNllpUWjPSR/BSrhI2lP48tEfxLhAeRk?=
 =?us-ascii?Q?D3xZ0BkzWkmdEEWLsrR1e9BTdoyZlokVU+MxfUfMhSqiqHHszYHeiQNvTLQo?=
 =?us-ascii?Q?XZTHGw0OVihWAc1JEmBJIwx+c+2p0Yu51zdPkej8jmxCDjW5kxeDx7JN+CIh?=
 =?us-ascii?Q?5OdzF16KaCfznMNrVohK/FStGrmN1SGqufNJMB0V03PYmaOO0L4Re5W6HJSc?=
 =?us-ascii?Q?bNbu80u1t6ZrKgiCalMtpGHZKG2DP1zUs7j9B90iByRTmyamdAlBtlBG7hP2?=
 =?us-ascii?Q?SvgUeLNnu8j3gcDin5MyNYgD56z/6sfDfu/b/pEhpDC4nbRpr0Hou1OM9F/9?=
 =?us-ascii?Q?/jDFYx6+c8CPiwaeUfa9OUV7aLvFzLo8wC03C02t1DWxH5YQXHMWbQaWk4Eo?=
 =?us-ascii?Q?K8TusyT/cO2xeShHMvgYhMIvZeSZG3mMb0dqZ1JEo3Zeip1i7wx4fP0GuFMD?=
 =?us-ascii?Q?XYLPAkI3e4JHBcROunEa4mc6T5CfFieqjykOlAa85D4xzNhaZkgBLbUZfbLz?=
 =?us-ascii?Q?zC0Z2nlNvWvtMaNbe3o2A+99HNkxnSIGWcJrqrEeNe1qDK/R4eUOFhZVBKQB?=
 =?us-ascii?Q?ZcTFm3QCpJXTIoXNMQKniFqyJVynGAn8Re7FG+xzcn9kHHJ1zDPlPKQNpTyj?=
 =?us-ascii?Q?3YrxqMkoC3MqjId66LU+CRijGubGcUVzk5bboN9N9faIKM1MMjO3O6BYVssX?=
 =?us-ascii?Q?KisMkKDm9iHb+LvYKOttinCoMU0JgXqzIPKdVEQw12Q1p9GbjMhnfTsqJp8S?=
 =?us-ascii?Q?bx8cnb5wsjoOHYltFeE3RlKaKxguP4OAHoxou6ygEmk3Z9WQhYLNt2kb/Z3/?=
 =?us-ascii?Q?935v7axINXG/Wq0gx25GCh9PtxTPnsqTWVNc88cs7tJTbOkZhYjgPHccBh02?=
 =?us-ascii?Q?7E28IjpTZNt2/130AQjv2gT4QpyimHQ5am5CIK66jIp6srm8n87EWk9/+mAl?=
 =?us-ascii?Q?Iib9ZEL4cqVr+HtTeXSVNFKTwAEr/4UciXL3RTDU1yht3fAUSLZYOdslGd18?=
 =?us-ascii?Q?qaOyCWhoRc1VaYhADI6RZRwonUHcjUC45l4bQakQcbCCeCFvKAISOCHgxAel?=
 =?us-ascii?Q?UjnfnsiRyhHn+qVF939i+/1I5NpeBrbsep1VxFg33Eem1Wl1rMucbqJVbGcP?=
 =?us-ascii?Q?HgaFGQLfK54RYmrqXPzVBvVskl6NTOG11C4Tmxp3I1IM?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997A1FFBF28D64279710E1582712PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d165847a-9744-49b1-3ee9-08dc18277d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 13:15:06.7136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiCU+c5xcFG1fVIr34QwWxYHmqcflGNxqd6C1vnTp38bKJz3ItxE0WoXOVwUYABe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB5997A1FFBF28D64279710E1582712PH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

The title and description don't seem right.

Remove smu?

Best Regards,
Kevin
________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, January 18, 2024 14:43
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_=
0_6

Add log info for umc_v12_0 and smu_v13_0_6.

v2:
 Delete redundant logs.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)
 {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
         return (amdgpu_ras_is_poison_mode_supported(adev) &&
                 (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 Val) =3D=3D 1) &&
                 (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 Deferred) =3D=3D 1));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
         uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
         int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                 return; /* Presumably process exited. */
+       }

         user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
         if (unlikely(user_gpu_id =3D=3D -EINVAL)) {
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node=
 *dev, u32 pasid)
                 }
         }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
         rcu_read_unlock();

         /* user application will handle SIGBUS signal */
--
2.34.1


--_000_PH7PR12MB5997A1FFBF28D64279710E1582712PH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">The title and description don't seem right.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Remove smu?</div>
<div dir=3D"ltr">
<div><br>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">Best Regards,<span></sp=
an></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 18, 2024 14:43<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Candice &=
lt;Candice.Li@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;=
; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and s=
mu_v13_0_6
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add log info for umc_v12_0 and smu_v13_0_6.<br>
<br>
v2:<br>
&nbsp;Delete redundant logs.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; | 11 +++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c |&nbsp; 6 +++++-<br>
&nbsp;2 files changed, 16 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index 6423dca5b777..fa2168f1d3bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)<br>
&nbsp;<br>
&nbsp;bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mc_umc_status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison=
),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferr=
ed),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC),<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC),<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; );<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (amdgpu_ras_is_pois=
on_mode_supported(adev) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STAT=
UST0, Val) =3D=3D 1) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STAT=
UST0, Deferred) =3D=3D 1));<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 11923964ce9a..51bb98db5d7a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t id =3D KFD_FIRST_=
NONSIGNAL_EVENT_ID;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int user_gpu_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev, &quot;Not find process with pasid=
:%d\n&quot;, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return; /* Presumably process exited. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_gpu_id =3D kfd_proces=
s_get_user_gpu_id(p, dev-&gt;id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(user_gpu_id =
=3D=3D -EINVAL)) {<br>
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node=
 *dev, u32 pasid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev, &quot;=
Send SIGBUS to process %s(pasid:%d)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p-&gt;lead_thread-&gt;comm, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_unlock();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user application will h=
andle SIGBUS signal */<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB5997A1FFBF28D64279710E1582712PH7PR12MB5997namp_--
