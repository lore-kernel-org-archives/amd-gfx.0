Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802ABE9DE6B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EE010E7A0;
	Thu,  9 Apr 2026 08:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qb1UX5f0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F6A10E7A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 08:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6xap9RdAXCJdhCo65W/Htd+4XQ+nS4/l5BHyNy/f4l5Ni1DD9sXsjeBDlR4zlBvHH5M/quYw9muWNYaK5FC3H6oNLURBc/emaXt5qYKPdNWwtkeiBudgG5mD2k+1OKQwXQw8egiphTVSOQAPjSC/H9dmCo/tC70v9KxYiKJwoMwfhj5/h/kmxL42sg2JELunUW9OwjaZbBFMQf0+7zvkoiX9FJZHEiTZA/9idpPo3zrgYUBp/XXnlK6+Tfx6UzBaHEE6Uw6lSE+phnUxMq++StYK6jZQ6rhjaApLic49Xj6xDvMWAubx+0b2VtuTsdJOAgOKjaSdT8OvsSnHGdD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFT2CON5yBSImRY8AoP42dEkwwd35lQykgm251gpiEo=;
 b=dDarEB6hF4RFFor/mOxGKyekPdJ5C0jGuOjNGd87Ar5NnMt8M1R03Lr0atEyULmS4lu0WGXJHE7R9I3k+NOC64Qjpi93hO45tf2OkNnmW7voWq2FD4yBUbsoojSckiuSpP+L2CxD8xmOLCtjiQHSWQtSFtol/KAX3adeq/zm7Exsyu4Sfc/++GhWRD4qd1XZcaxwXrPbmrFdlYL8gl5HDFacVBAAaXmIBOWVaqQExx9fU76uqxGrVENZDkQPsnL7oQRmJbSdMMsgOa+B4Ipk+/yUCOWyxb0Zd0eus16Kv4kk1g43v0BSly7kX2IFTrkqueJjjGiZbif6PKzYrpVLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFT2CON5yBSImRY8AoP42dEkwwd35lQykgm251gpiEo=;
 b=qb1UX5f02yxIGz780+wg6Pqc7UaBcjereNW618kUJOQPzU0cgkMcsekSYRXvu0ywPIF5tRXTSgGGlglbH3guy5HhdGY+MdfxBi37h2iNYrMEVUBceoPRcyLKxV0VA9hs0xS3ptE5bpFJ5iO2e0gJCUnt2FZIK+lXigi8DucGwsk=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.41; Thu, 9 Apr
 2026 08:41:13 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 08:41:13 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Topic: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Index: AQHcxz4zumhideOJzUempzuEjhLrobXVBHUAgAFGIYCAAAqBgA==
Date: Thu, 9 Apr 2026 08:41:13 +0000
Message-ID: <DM6PR12MB29727C83419B6AF128622B3B82582@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260408095739.59807-1-YuanShang.Mao@amd.com>
 <DM6PR12MB297293A460D5D4D174BBB7E7825BA@DM6PR12MB2972.namprd12.prod.outlook.com>
 <PH0PR12MB54204DD72541956A251F7C09E0582@PH0PR12MB5420.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54204DD72541956A251F7C09E0582@PH0PR12MB5420.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T11:18:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|LV2PR12MB5871:EE_
x-ms-office365-filtering-correlation-id: c4ebfd10-b9c2-4346-2c6a-08de9613c1e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: fHHNjruXV1dh+KZnT658JBv69V4BIlA25LDbFs3F9eXnJNUl/y0bi0hig8cVWffioNrUhE4JSuyI8ZHAFW72BSS61i5klMzB8aQ+l31GYoTcBpHNGJOlMb+MZTcQwlJUPiGpc5FlVRCpwwK6fnnUAAj1njZQ9U3pbFgp+vTx/cJAMpBGbLViCyB6QknBY4oFzXDU4Ej2k0IEyrkG+FNLhuaoq702ZE7Ye5RfFHVAiU01nNKI1rj1QXavqxeMoegLD0jcpSsYmtFzQuoACHJ9VE8D3QlMwwUFkHZF7mvoCVGTJkCmnu3Od7Na1rU1osBmBeMrLIo34XqE5QbY7PTbR8liSXvEmX5s4GmGu+YDHWhHQ7Lj+y8HS0BjOFu5YwFJYrHppzfK5culaFmgUlflgmWz939gYS+m7ZA5QNuJF0xDNQM0eKoHiCYTGLarLgikpGv6poBKvWyEddQOwBFqxoSoFrtf0wUey0x3mNJvd5Ij30jdwKytbHnD+EnguDixo2MpEYSs+ppRo4L4JSb3za4tVgJJk4dsDSP+iBsRd8lVkSx/a493AXk/iLnjn2t0CshvfjlSWA5WJh4B8qdFu/hbNppaOCyt2zcH1q8getfqCRfbKtrTiZXv97fc4NfI/I6k2V95nakCTIzQLBn5lzs7TrD0Js/JzhfZ5T1tW8PSmf6ZTpXsByeV70+OgwckfLAc1r0CHI/ccVM5BfTPCIQ7U2ymmF8R+KHYbl5lGF+598pCf1HQ8w4nVnwFAc+bFe6F6lJdSzC/bwNOreGBorPTkIjq/LMaRDKHnWeiCcw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VfB3JY4dx7sek2CVBKnNFi8N++pQRVcYZJUjXmX6AqJCL6e1dWyu1z4mTXGo?=
 =?us-ascii?Q?IfHy4cE8bGYHLHyI9Y4JBUM+bWcNgwQ+DZSTCqmvQiDShDYy5llTru01oLbz?=
 =?us-ascii?Q?BJnxaeYRH09bvBNZXOVrstYYkrpYPWD8pyW0CA+FtIR+WIAp+dKUpw8KZ8Pn?=
 =?us-ascii?Q?6r0PKGe86P5SoeDMEFJX8RlBe/cgg2mnQlav7ckiQanctE2XY3qdT3DG+6ix?=
 =?us-ascii?Q?dHnP280dzFfeKMfdRgwOl94O7Gsp/sbylGQxp04pbosWku5T7hG2M1b56QHJ?=
 =?us-ascii?Q?0yWZ1a0u6geW59e9Z1RtWrz7qSjhBLlrwA4fl0F0oljSZq+B+cKB3tLs77MO?=
 =?us-ascii?Q?YP2JTEZsOOmRWauh4Vaz9bNLXsbx3x4TrL7aw1GxDUlcWw5ArrFS4rkF2vsw?=
 =?us-ascii?Q?2R/Q/I8ZqxeE0L36s9QqN8R2II7e2bMLJp0r929UZrX+qEfqGg6AYX7eHtVo?=
 =?us-ascii?Q?0ZfQjdLgD7QXHIEbJYhfLqZyf9R0BFKSRliSXaXCje7dkJpzMWx+kw0fo1F1?=
 =?us-ascii?Q?C95AiGaNLDZJ1LnQXPWDy32oIxT/4bSxXS+8UhkndPfP5gKALDVtOym/itLl?=
 =?us-ascii?Q?xN8paCBEyjmIdQTTbUU4oIige1vTsf3zdgSVh7hZAsDSb9mX7qU31y0/gUUg?=
 =?us-ascii?Q?UZP6m1Mhfja4RElrwgs856LsHjTkIFATf9XKODoMchP4/CQOyiL0Apao/DGw?=
 =?us-ascii?Q?KJZqJ8KqGsfXtWS6JB2SpyoRPFVg1ousiH0G6CKCEuKpaUZLvvsYbjfN2YCX?=
 =?us-ascii?Q?0BPZv6k3IeYgrA01IlR6aWETFPEwEVqBb2xtjKYHVXRvfsX8d28bmPXElAQq?=
 =?us-ascii?Q?KEihxDyWc7JAoNHEUYLhB/1We5cvFLq3HUwKjQXG09tzeZ7N5qFfhfDOpqUq?=
 =?us-ascii?Q?Whl8iBhPXKERk79a5La1dcFdJz8FHyadfuWyyyvHz2gBq6QDK8ifD/Jivbj9?=
 =?us-ascii?Q?daApnL3CuSlIpQ7W+XnIVYWG65lhUfqEGZXHf+BwODfPLr0zwk862a43JHaR?=
 =?us-ascii?Q?0ntSN3DAAxMwEFsTuDdFTuoUU/uYMNqsBMh4x1UvGeC1i+kn56sN/Ja0cdw6?=
 =?us-ascii?Q?aPPmHbTPk4u3LfKzi5Kdxtx6OJrOTEW90nCZTiqHjEqBbqaTiN07uTziBg0e?=
 =?us-ascii?Q?ICxC3UAB1KWyPH8jG4kpgV88K90DrrPNkG0+qSshh5/CdoZGozHlcwpnuxFZ?=
 =?us-ascii?Q?2sVc9s2N6445zWoJbBon1ow1ivprwWoezJiUlPwVcyszUlvxkm/D6UZxbFRO?=
 =?us-ascii?Q?NVm0rNRtqOjJNzHTLpGNvALZyFbnBR5Hsqww7QhOTI+TK5l7MsWaaQRdjqiC?=
 =?us-ascii?Q?VEn58lC0svN7Ix+yoXSJhWGHTi6aeyvoGaVLNjebN/nv2/OEHXV2Yb3RSecv?=
 =?us-ascii?Q?AoKIizKXY89Xqj1L08zftt/JTaGsBiu0lc35YQgSPZDR8kn+dDmBvcbgt1LE?=
 =?us-ascii?Q?9oT7mwDgFq+zKuIs9VK7wZJHZO5e4hKy+lMNjjB8Nh6BsnOKTAlOC9P/eif+?=
 =?us-ascii?Q?IwkaH0/7E5PcBild+HKCxejiO4CrV/YzX14lQskenJYe4Y4fCMrZG3uLNcE0?=
 =?us-ascii?Q?8NRVvcuWh1P8A/+FfZlux0rIINwBjhrVzzbyst4iZ1vYM4TpfqURAKq9MTW6?=
 =?us-ascii?Q?eeEeFI1hnvAQEiNykWrg+cRsY68Fmlvi0TQj7W0XENULUOfCz+4h/vTNr5jH?=
 =?us-ascii?Q?RrFAP7oinbnvd7tKRN/ZefJ9MjXLZ4dM30Xz+/LgtpOOivcu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ebfd10-b9c2-4346-2c6a-08de9613c1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 08:41:13.4563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUX2+cLPujrh4kQ35FOvTq7yOPJo0k1mCc4E1vxwwifasN8vhnlOQFyn9ulOVCQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

For legacy Asics, the PMFW refuses to configure DPM clock from one vf mode,=
 so all WRITE operations are removed from sysfs store operation in amdgpu_p=
m.c

If you encounter any problems, please create IP specific patch to enable it=
 to avoid introducing new issues.

Best Regards,
Kevin

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Thursday, April 9, 2026 14:46
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission che=
ck

[AMD Official Use Only - AMD Internal Distribution Only]

Comment " setting should not be allowed from VF if not in one VF mode" mean=
s setting is allowed in one VF mode, right?

I am testing the function of setting clk level on one VF mode and find the =
node cannot be written.

Thanks
River

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, April 8, 2026 7:21 PM
To: YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission che=
ck

[AMD Official Use Only - AMD Internal Distribution Only]

I'm a bit confused about your patch.

The original intent was to disallow write operations when in one-VF mode.

After your change, the condition becomes if (is_vf && !is_one_vf) , does th=
is mean multi-VF mode?

In multi-VF mode, we should not create any power-related nodes, as the SMU =
IP block will not be enabled on the guest VF side.

BTW, what issue are you having?

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g
Sent: Wednesday, April 8, 2026 5:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check

The condition was checking if VF is in one-VF mode to disable writes, but s=
hould check if VF is NOT in one-VF mode. Add the missing negation.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 938361ecae05..17fea9a2aa28 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2057,7 +2057,7 @@ static int pp_dpm_clk_default_attr_update(struct amdg=
pu_device *adev, struct amd
        }

        /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
                dev_attr->attr.mode &=3D ~S_IWUGO;
                dev_attr->store =3D NULL;
        }
--
2.25.1



