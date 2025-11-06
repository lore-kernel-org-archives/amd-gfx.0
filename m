Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F132CCFA1A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66EB10E877;
	Thu,  6 Nov 2025 10:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ast4a2/Y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3C510E86D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3f11WGKW9yVAFsFglAt9prc/kUGMa39XJHl6IyYfZT5gd4yzBzqYFJbOcgBEPkMt7CJbbGRFiTowdTO0tBfELPCID4A4cIYMEkki8iYnM2RnIKy6msFRQttNs9rN3593T5h3OR/nbc3tNDtW0PCEDWk++iVAJhrtUe1lG7/e/ywEPvTpmHEH93Nn83WTZwED3FTyyMJLaOxYdDSSsbLaqfO3YvYx3BBT0cKTwgtzlMtPFST3GmB0jRtZCSlJFYL6+u8c1lGklglPyUdCsngn+heVyFRoEU0Q73MsBB4EBnrVol/9bQ4yKyXU6kKtzjIP+7uBO8br4dfodp8GiT2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpa5fOqHoPoeY/7OwH/QiWRs7z4ZWc9E/FTl/HnY2Ek=;
 b=yOM+6PeWHGuVBosKWylqCjzqV8E0Lyh8szmNsqNovm+1qLCsawM5FZ8D6KfZZaB9OnNP90CMOk1+uNJga75AiLZF31b98B6Y2vcsMU5TWwI+kG7xtG4Ciz87Wtob/Lb0ZJWqUjWG15tpbq3i1V7Y15OvBJ21f0dVnqxkfYBUeT8AOvsDjOGOmGyN3GkAKnwszPMlCjzJiLfJ944r7+hHHnuCHlvNYETXZ98qtjeGM7ZfDcJmpyl4Ae9u2KyFypj8QowPlsOfwNqp4wyAmW8F5AFPREF0wJzEq1B6vQ1n7rvoDD3gwPWY91A0uWwpDGgrBY3bpUY+2tV0UuoNWQLPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpa5fOqHoPoeY/7OwH/QiWRs7z4ZWc9E/FTl/HnY2Ek=;
 b=ast4a2/YjYWPQiVlK6u+D2iuUqNKPBvkIGK/QH8L7J8+8I+83Q7+6UvZrZXbYas3/TmHu6qq2MTeOtzk07u5JpMczsejql/t2wdA/ZyJzJnK2NwKCcOmgJBn4L27cvtHmQn+xQ7PMoKC2blkadq/5w8lZEz13Ii7tKlNTiy/1WI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:03:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:03:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Topic: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Index: AQHcTvqeD9QlNux68kGqd1dj4r2gi7Tlax4A
Date: Thu, 6 Nov 2025 10:03:26 +0000
Message-ID: <BN9PR12MB52570B0815AE2C7F71BCBF0BFCC2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251106085125.1949875-1-ganglxie@amd.com>
In-Reply-To: <20251106085125.1949875-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T10:03:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: eaed2ece-a511-43d3-e14e-08de1d1bba5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MmeC0sPZaK1yCZn4wrw12YenbjBnU2IiYVruIMWXde0+m87/KofpQVP+sSpH?=
 =?us-ascii?Q?ynBBJNVQc16nWu/uOBRT3sIpZ1NZHMfH7G+jCRRiDhSJ15luSVNWrXH0uUTg?=
 =?us-ascii?Q?h7PztICW76SPvjIsu6hljUe2Pl3X5iY7V1aAiHW9xIrZ/++7Wywttk6s3kug?=
 =?us-ascii?Q?hBFmWkQIlpLCtlmxRiGCvpk3vr1WSee4jpRSzpsuegp5sHAqiSBt6Z4/RQl8?=
 =?us-ascii?Q?8lTjXhM+wAn6zDAEcclFZrP+nE6xPDv0iGYHz9Wlth69IrU16hbLoOsW9IJr?=
 =?us-ascii?Q?SZwMLxdWSYCj/EJm1eku0E/8aJOn45enIRH7f6oNjc6B5pI/Y8uuBsaX6p1q?=
 =?us-ascii?Q?erEgtqywh8zzed6h/3JOIetzt2Rx4dHYgN5ro+YFLqPtRPs8F/9VsL+hCV+u?=
 =?us-ascii?Q?Kl6k2FLpQwurOHrqshxFiD+JCHun68qw/eM9GTfVT/KhAfy940WWv3yC/c5l?=
 =?us-ascii?Q?MYaESLnsWVNBMbcjcGuMaTprQmZI+a4x88GU3xaZ2zKNaAYNVyKpY0TPmRBC?=
 =?us-ascii?Q?i6WMuSAxoN8rKuFlMSnKpCR1U/5LY0B2gJMSDEBMUo5m8JllbxW3rTexxlUa?=
 =?us-ascii?Q?1tWU3AdgqglDAFL2lanyzf+yLlvbRNNTKpNKZccqHktjANyH3x3qpK07fnrS?=
 =?us-ascii?Q?/Y8fpcMDSe99weJv7/zBr8b1x5EzYw0YJXpN2s151awv7afqTrWjrHjTNTBG?=
 =?us-ascii?Q?oCiItmQWlvEXd+ZxmzRt0yCkYNN/5XyUI/u3O2j33D3dOgCilwFZrERrZ2FX?=
 =?us-ascii?Q?UeWQrm2ADCvuHwqfNqAYsgIO5U1UYgtZqK1nQnEqYBsWN3qZstkDs7uXw30d?=
 =?us-ascii?Q?96rJ2Hr4FA6vGf7SYLLdB9kKpvkz7njgBSjQ4GyvlpJvemV7IpEgfzhsbBa8?=
 =?us-ascii?Q?qAZdAxUSHjRLzk8++Rtl/denVhULK4REK0XuJlR68F+Y6SdvkgcmHtnzl8MK?=
 =?us-ascii?Q?bGyB+iaR5P28io50yI1ZVfOJS+g5WY+i6jFMgBagwb7iHZl4V8idx4h38KRv?=
 =?us-ascii?Q?R55hpqcA5qufwGx1TmWs/dOfgKa1TcPiEEBLNWXFu8dhoZMHWMNZkxuXyRpc?=
 =?us-ascii?Q?DbsZ6yjDR5Vi8IzoGvYdQOzAMDxsa7T5+QaNDQ7MZLgZFpv27UrrOMaPudQd?=
 =?us-ascii?Q?QSArVDviKF4HqljXkrjJCn5AqpXsCOZMPoFJ7tMKuu7Rk7bDknZ/yRsW5SDa?=
 =?us-ascii?Q?YLgiA9bx4Dwta3EtNKVBxoDAZ4gvDVjWWPt2yw2LzvqkVjAJrGCYzYRq+Ndi?=
 =?us-ascii?Q?W3vHJ5/1vAG34c21SnkTg2B6EwJemsI5J8nO1elkw6r5d7BzsLFEzu2lLiTV?=
 =?us-ascii?Q?EaJZaBwWGuOaEufQzYUAKPinRDVXUi0b2RDFY1k0tnjpz1v/5blIUBVX+LNj?=
 =?us-ascii?Q?5D38t0mkqT42xUJFntKEBnv86NGJligukqt/bQdZDu4HYtHv/dWNmf6s/aQG?=
 =?us-ascii?Q?FwxgVssjFgRQz8mL6pLqjUK2c2XCvMFTCVzCT1PzQw0QYdIG2rD4x/lmGX++?=
 =?us-ascii?Q?wLyY9mEQ7Ujd0eFyLB434ghI5eiFk5zgzpWW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ecoT/inkte0DQzwFeRLbVYsqjtav1bpvzlYslYK8lhOd2a0z69NYXGPTSyQZ?=
 =?us-ascii?Q?MZhad0PGnDmOvYl6XYgy7aU0xj9O+lR6REW58N47yRrStB/eii+5TD+Imziu?=
 =?us-ascii?Q?6c0CHvB9mSR6WWjIVHeRpYpfMNpIrrObqBgMywuTN4W26xXGiPt+SsrIg2yu?=
 =?us-ascii?Q?cFLD4ynQEKF2D6e8tSyTWn/0p5vzEacNt51ngqYl4tjl9GQ3h4H4UZCwj1xI?=
 =?us-ascii?Q?zZ0/gjwBoBMNG9rwcr/qHOrlYPK7iouu2JUKxJUGY38LxACBai07bwnYTVfb?=
 =?us-ascii?Q?DTp9eVqCfmH/lcIynrqENIovbPHDtyF2w1clBP4S0ipi3I3Sp+G4SdQGyvdP?=
 =?us-ascii?Q?stztIJReyiLMErEAiAxFSyPNj3rlng+XvGj966du6+0LfD5e/o2E7r+295BN?=
 =?us-ascii?Q?HzAbPsNCwwEeBxk82x/nfrF2gC191gvfJR+1HINzLOr7UsQO5aDfHRAM56kA?=
 =?us-ascii?Q?D543dR0VNKeO2i4ngwVrzMxGRlbeIoyuoLoMMO1Dn4+m7Qv2PPom5ESaKboQ?=
 =?us-ascii?Q?fLk42Bt8Mo8FPuqA2qT44W8l8qK0tBK7vsBRdhx99Y2U2jQvMCt0sPc/zYpk?=
 =?us-ascii?Q?QeMoWsLCXk72MCuwbjhP86cjnN6uDR/u6ney/fFDGE0y6EcTi5P5LKglelM0?=
 =?us-ascii?Q?8UVCwrMpY/L8NFclBOKqwet+0YlbE3bqhaELPYDrKMvPHjQMkYyxdzbP+Mym?=
 =?us-ascii?Q?2CaIQ2SIkq7Hbv5dpee8dH6wBtCFTH6it2W8owoyY5Igu6PWSQsKbtPqnEBp?=
 =?us-ascii?Q?bZDm/a/gF9RUvFcM3JxtBYAu8kwqtrnJg6r+OWiCttfhYW09EgHeJ6Mkq+Tt?=
 =?us-ascii?Q?0PFr2WhAAhbLSak7rNXRPoZ/C0AQkE+sErdl8GzYSLY6iMveQ6xjEOXhobL5?=
 =?us-ascii?Q?IdhbdjdqFLazvKH0yu/zc0CgXgXkg78nXHuxIAWpmnS9sYSX0CsbOx00W2TB?=
 =?us-ascii?Q?6z3i1iinM/Hg0lIfnnSZBzCzaFqRTQKuUoAZ2EkeORrnk6sWJP9XiEuLJSG2?=
 =?us-ascii?Q?MZu+9wAGSpbcA1OKMaPsnKVaV3jI6upQXdKCJDwMM4wapV3WK5jUuM80QG8R?=
 =?us-ascii?Q?jTpjwmGRvVEo4TwmkF8uL21bVBFza04HXj0gcr3gS/22p8OaGNUt6vIMs6kB?=
 =?us-ascii?Q?GeRvsNwWS9ve5WpCQHzvgCNWAj6RsXPsDU+D3qTOnxKayHdBON4g1JXcNZg7?=
 =?us-ascii?Q?LwvJVnHV46PtFIazC2kpCz9h1T4mFUI1UBo3FxC0s4oIh1NHEuHm/lobWaDh?=
 =?us-ascii?Q?kg5fvkMXHSrhPikm6cZnueUVhIaBhlGMS192z0bGnkM6nv5wG+cUwM7NVXo6?=
 =?us-ascii?Q?bWzv/RStSRshLjf85wLTpL1z4dvxOgD+2jih05MUQn19fVSNxq04kXt0B/R2?=
 =?us-ascii?Q?1hHNiZXuttxVu1kpHF9HsWkgWhK/kw0nlWm7iEKLn9WSrCkE32rAMmT66VEW?=
 =?us-ascii?Q?TRo9AjowLVPoPljcFAyhciKAGL5bZTpGA3w88oTcTKXLBtGZ3FIacMv8qm1X?=
 =?us-ascii?Q?kWf1shAq+T8rdsQ69PBkE6fnqEHZLdEO2jVrpEfFyDs4RH1SILWVTEUgTTp1?=
 =?us-ascii?Q?2kHZsrxdRNySLtpxKTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed2ece-a511-43d3-e14e-08de1d1bba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:03:26.1028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jC92iwiJ6dxChaH+SGN/YoBGTBv5UkJpJqvPMXmJRR5IJcOwH0vWFwJLanjwzfd38dyj4K1qWUv0YyIDFCO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Thursday, November 6, 2025 16:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy

smu busy is a normal case when calling SMU_MSG_GetBadPageCount, so no need =
to print error status at each time.Instead, only print error status when ti=
meout given by user is reached.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ce8cff27bf9..fc580800609c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -956,6 +956,8 @@ static int smu_v13_0_12_get_badpage_count(struct amdgpu=
_device *adev, uint32_t *
                now =3D (uint64_t)ktime_to_ms(ktime_get());
        } while (now < end);

+       dev_err(adev->dev,
+                        "smu get bad page count timeout!\n");
        return ret;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 3b98065dac1d..4040ff926544 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -164,9 +164,13 @@ static void __smu_cmn_reg_print_error(struct smu_conte=
xt *smu,
                                    msg_index, param, message);
                break;
        case SMU_RESP_BUSY_OTHER:
-               dev_err_ratelimited(adev->dev,
-                                   "SMU: I'm very busy for your command: i=
ndex:%d param:0x%08X message:%s",
-                                   msg_index, param, message);
+               /* It is normal for SMU_MSG_GetBadPageCount to return busy
+                * so don't print error at this case.
+                */
+               if (msg !=3D SMU_MSG_GetBadPageCount)
+                       dev_err_ratelimited(adev->dev,
+                                               "SMU: I'm very busy for you=
r command: index:%d param:0x%08X message:%s",
+                                               msg_index, param, message);
                break;
        case SMU_RESP_DEBUG_END:
                dev_err_ratelimited(adev->dev,
--
2.34.1

