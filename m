Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A339C27C79
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 02:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BA310E043;
	Tue, 18 Jun 2024 02:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vMVzr76P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6326010E043
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 02:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9SkE0GKUEzlHHvUNYaxCjoJhNKZo9E87UVw2cMwR2dzSAt37cSJCeky5mjtK2+KwRxY6JZXwNpmg+rR/1bHyOUwJw3ESpzxq10QvAD0RDV2T8AKSaNAJjYAy9M1q+QLReEdoIj5MwQBFXlPQAix46JLTgKHql5rTOxEjmLzu1ZXgMpv1KGsRUpK1861Xl2sgXfQl6uuRJ390PjbtDQ8NUAdyuRhh0+aRmfjJYcc0AWup6JY4QqTVpvKf5oqPb2zXHDG79xYaq40T4xW9CcnjXNHygneNQvIGFkch8Vo81LvjrnpSKlFZzN7s+ae8baApFcB0rm9usfPM1h7KlMJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIBRWilVRoLpRt9/Jo8eNZ5ttooDyfjMWZFoO6Say3M=;
 b=Qkp72+iGVplZHgrUm5w7eJaSju3F1XU6jtVKcNCbrGxw+9iN3dlmyFVeGn6Xol9W0+KTqJ8UxOgbqrapWyEWyY6YiQ/DJCzxq58n1CYobVkSuEJ3jTkqiI4Rz/ul8i8qJXbJa+ruS1YrNbnY4OkHAdwiG7+z0OpKtpW6TFUo6xI6Jz/+D7SUPyT74ihXjM5DbJlhcyxDAnQq8CBJYtn/ePkb3aXAOndE71U5kIKFdfjrglj7CZ5GB8RW3cQ3aIgYKr5Sp9XLK8DddR2yOasmwu66+Pn99ylUSs7aR/+BfgPuN4o5mr21G3gqSyQQ9R6tpFpQxzH7E0lPTcN+ldE5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIBRWilVRoLpRt9/Jo8eNZ5ttooDyfjMWZFoO6Say3M=;
 b=vMVzr76PR9NtIXEDrcjUFgFAR017MzyAKcQ+OBIAFSEET6C//epAWWdGektHIFDR7iz878Xrj8kPjR7gFGpf39YFIRlqjM99ZOgg6r/9dNJgnc1P68eH0IdtDfP689qJYh/KvBycjYVFj8KDSppzN9PavZzIl4qDmFRrMUx0KaU=
Received: from BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 02:38:35 +0000
Received: from BL1PR12MB5876.namprd12.prod.outlook.com
 ([fe80::d4f3:971a:655b:8411]) by BL1PR12MB5876.namprd12.prod.outlook.com
 ([fe80::d4f3:971a:655b:8411%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:38:35 +0000
From: "Ma, Qing (Mark)" <Qing.Ma@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov
Thread-Topic: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov
Thread-Index: AQHawJ6yG9MRHjnr0Eah5LuMwQ1JL7HMzoyAgAABVvA=
Date: Tue, 18 Jun 2024 02:38:35 +0000
Message-ID: <BL1PR12MB5876B16AE2B4EA8E86DDAE92EECE2@BL1PR12MB5876.namprd12.prod.outlook.com>
References: <20240617101114.243566-1-Jane.Jian@amd.com>
 <PH0PR12MB5481DE5A3D1130C9504953C7FFCE2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481DE5A3D1130C9504953C7FFCE2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e5190107-8d6a-4366-9ee1-4225422fefcf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T02:33:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5876:EE_|SN7PR12MB8792:EE_
x-ms-office365-filtering-correlation-id: 0026e704-e05b-45e9-9c78-08dc8f3fc06b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?9839SpqZWh2pVxZBnZan+mCMVVYXO8T911dHRpc5rD31jYG//8oOqP/pcRdU?=
 =?us-ascii?Q?+qOKLIL9wInokni8dUndKFZAPo8158hX169j4ROzek5MZ/NWWCkUbRjO2ZqJ?=
 =?us-ascii?Q?7giotq7gqv6yLq1VjZ4pOcHkxnu6WiOW454Fw9PChss6OQs3TCIKj2BPprY9?=
 =?us-ascii?Q?6uvxOuBBxMeQGf9uWiBMGTcpnfgDmOqCuQlOZKaqGrHMU1GfwQIno2uHha1t?=
 =?us-ascii?Q?tayNNRpF/yxeHyUSrxyKSaxdiM+erFTKqerMEbFYySVh2I4I7KgGJYB3j3yp?=
 =?us-ascii?Q?qmWC3trnos22CbmxVwZnFWBQjrfrkAYNnqvHqmls0KwRZXJDTm4GZOKVrHjq?=
 =?us-ascii?Q?EBVKMEh3yQElPUGcuuJ9auPZNSrjmzvr7os+M4REj+FYNmg7HQnysdKqCeqt?=
 =?us-ascii?Q?r/9cEM8RLTFXYD2o96o4Sz63CyWLhVPaoAxmL5Rhm46nRBn0k5OdqmeuiCGZ?=
 =?us-ascii?Q?r1MH0Y22dKJAB9IPwy3QxmLHUNvJkrgxo6iB1ayOKT0DsSVWANV3gnRw41HX?=
 =?us-ascii?Q?ZlUZY2KR5vcs0PC3tozezTy/DnKxBVoOjhMok6SZsyLLsR0vJjOFIVI7GNJZ?=
 =?us-ascii?Q?UTbL7YEpKiKvYKU1NPQhuMDlMtbobgNAAQIPcLyABO1c0jI/sYQyqHwNDb+5?=
 =?us-ascii?Q?1lqER1Ur49Vb8ivZSL8UCwOZ+S9Ooz+A1oWfklWsolunIoJFg7DKMgjJFKk+?=
 =?us-ascii?Q?xZQW6Sfst1Psh/UcB3fWaHENA6OWTWVt5ZzdQIF6jsrI/itRbJJtBvd4NQJy?=
 =?us-ascii?Q?9rPljIy83RCndg5ibalrIovCT1bfnk2LfCavyXkdEHXDzGnLFeJZNnu30Drn?=
 =?us-ascii?Q?A3p1YRMnqUVYBdRNz5M3VPPhBYpIw4sFJBVMzbHiLNQhVzXBvnSBJnfDqovD?=
 =?us-ascii?Q?2SrEk+tLo0rt5QnsDcg++P9T/FQaYmtpXcRqzS+sCJHs365bG8X5UTqKfCgW?=
 =?us-ascii?Q?OAHUfamUq5xt99rYVqNXDUdGozOuiiIUp6XAzWxF62fq5dL67fsnYd5x1gmt?=
 =?us-ascii?Q?CAfejoQe8NITBDW8/BgsUhUWYVSYpvnvYe5lDdO03PwsFlJvv/AriqMRVWSf?=
 =?us-ascii?Q?nW7xEAJNbokVDG7FeM8Bd+OJnOFo029HcS7WLeynJiEHAlDCVEywsvWqEAer?=
 =?us-ascii?Q?YX5pV89f6vpipIHWSgwIlNWWgRelkYm/4pcC4O4ZtREBTB207tMLRPtU7S3+?=
 =?us-ascii?Q?4H2H+MgXwN07CompF/+/NUPjgn0B73G6e9cIOCCxrH/DYFDn3l2y+tM6yJJ4?=
 =?us-ascii?Q?9KW3byJnSr49rvo4zkmL0R9El+wBYnA3DzZ8lQ6nnWL33yAyz42YX7e6jryi?=
 =?us-ascii?Q?85hhkDq6yW/XzLbP8yaqKTQ8tMFW2noSgOXBRaAvDFHqDeCcdMhFQBVaLkZF?=
 =?us-ascii?Q?UizCE/c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5876.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VezWphREPSnJrBmP4LouqSOaC0dJRMEb9RIDwfrzbWEfS+ov7H/3HPbVl5kI?=
 =?us-ascii?Q?kblzEOoYCXpDP2Foty4wm87p9BiJ6zrTfyY/4BxcT9DA0867ltRLbUI6X/Ts?=
 =?us-ascii?Q?jFYX1AXxgz6cnVe8328yr2LNCDzPwtTfaFSW8lTjdk9HYzmOUCyAIr19+0ES?=
 =?us-ascii?Q?qJweS2W+ac1yYdKCRUgR+s5sskNqE+fzGPpnnS8XWiDwa/Pl6zJIH7FaKFlC?=
 =?us-ascii?Q?Yx0I/LYXCAZ2tS3bRpd3pQmXcL3esxgfO+UbnAqSS4icAZ01OKxnyBGSRzty?=
 =?us-ascii?Q?eR9aIKPvFVo3paN08/g6IKadWb6pFnoCVzVcjrh5Nj0W3m0IulaCnUIveGZO?=
 =?us-ascii?Q?dlChNT85WuGmOJJFz/EsCqqcR9j/xrBRyX43nCMHiOeALX612rZvdRrzxQw6?=
 =?us-ascii?Q?tv2X+GSW6ZluCPTuTdfuUyWa2/MF9ci/X2JjRDvKOokUIaizcx5ib2/okggf?=
 =?us-ascii?Q?wh0HPPAbvoxuPYXhlqrG8InmrONPTg6ZYbMSWcDhx9SsSqw16O6H+QzTf2vX?=
 =?us-ascii?Q?77pKny5L6mBKUM9he0wOijW/A5EwHzTcnBxx0cTKsDrAS1peDQigt07oJyUS?=
 =?us-ascii?Q?uauDrGRLFEdYODx8RLDmzhMTfNfx1bsWDWenDBnQLcJRFQFmjqvrtq4CUSTc?=
 =?us-ascii?Q?ZpmWZy0EXgeEO6svNED0wek+VAPW8obnBkAxcxByv+L3lldIbeF5PRA/OWJr?=
 =?us-ascii?Q?g8ZTcNfcFcgohSx1aZFTIeT+veo5F5bWFXFBFnZC3JqGS9iTK5yatk33XO45?=
 =?us-ascii?Q?J9LDATs4ieqKt6MPD1ijh4DB8FrnzpZT/5jRNmvC22XFmL7eCk0e+eOE2nbH?=
 =?us-ascii?Q?FEnw9qvIkQ75fKBAHSftI20Gz8NmuX2B+qNV8g+1nR4BFIZbvpE/Su3zt5Qd?=
 =?us-ascii?Q?btzUMmPRRWFz3XZOf4IetJr0bzJkdfVPy47HpR91BwJilY5sZ2rxXoUq0wRL?=
 =?us-ascii?Q?EAkJ2w+XqGnokmyP44NpCEkPRpR6r9gJC3/lJDSeTz590YpN+7KirW3nP1cx?=
 =?us-ascii?Q?nIJ3dapw3JEmIwvUXBEZOhT8qTMu9q97xvmYpKAhr6guAslYHKwBG7xuqFNx?=
 =?us-ascii?Q?I9zwcP2WvgkU93qvkoDfFZS1QIDEexeJLEpvZZkHZdnaeo5OGSdSr8mSWW93?=
 =?us-ascii?Q?0YJP8Kn2hBAd3dyNN0/n6jWlrRgfBDAQyQISlpxh2Wysw3tIga0HsLtKxVy0?=
 =?us-ascii?Q?nxZGo1ugg7jHVa3PQhsRFwA3LqeZD8KTfCykUFBFTrP9Wi3k2A/DcihL95mS?=
 =?us-ascii?Q?QDNRcEM+x9xoXhBDvPAAjDPCSDpuHk7iI1fzsz80+Mtwb9yF4EIfKGaN7mXr?=
 =?us-ascii?Q?pP90JuqH5tRShf7FnM4yOCVwTgKGicVdy+PWcznX/RXzQODkwFpDHRf3Yi0C?=
 =?us-ascii?Q?BbNWlcTsWhRHtyx7zUAuvHyt/lI6icnwfpTU1FZFRDIEAGbNUwM2WiqZan+N?=
 =?us-ascii?Q?Ezc8SEQkRjAw+UoqWULbCkdnxGMrIqRGTC7ud6sWup2JCTl+9Z68ttVmRel6?=
 =?us-ascii?Q?fnuubTucAGSdM8P5QhUngFUVbfXJHvxMSXK2fx+jaeYXVjIC56/xeLqpsc8q?=
 =?us-ascii?Q?B9dsLRC6ZvH+rxZEgdpHPUBByPcX97GqyfiE3/XU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0026e704-e05b-45e9-9c78-08dc8f3fc06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:38:35.3316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tR+TTI5gLmiZ28qDuewijuqK+PuGH4QH6aFFNP9w94IPKbo4t3SgD1/WQRsZMYNKC3STUprp02oswSbsD6azAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

@Lazar, Lijo Can you help to review the code?
Thanks

-----Original Message-----
From: Jian, Jane <Jane.Jian@amd.com>
Sent: Tuesday, June 18, 2024 10:37 AM
To: Jian, Jane <Jane.Jian@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chang=
, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: normalize registers as local xcc to read/w=
rite under sriov

[AMD Official Use Only - AMD Internal Distribution Only]

Ping on this...
Thanks,
Jane

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>
Sent: Monday, June 17, 2024 6:11 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write=
 under sriov

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher=
 bit violation RLCG will mask xcd out and always assume it's accessing its =
own xcd

also fix the typo in sriov_w/rreg:
for KIQ case, use xcc with xcc_id to read and write

v2
amend some typos

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 63f2286858c4..d43652a38484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1075,6 +1075,10 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
        if (amdgpu_device_skip_hw_access(adev))
                return;

+       /* Select lower 16 bits to write in local xcc */
+       if ((hwip =3D=3D GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+               offset =3D NORMALIZE_XCC_REG_OFFSET(offset);
+
        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 true, &rlcg_flag)) {
                amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc=
_id); @@ -1084,7 +1088,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *ad=
ev,
        if (acc_flags & AMDGPU_REGS_NO_KIQ)
                WREG32_NO_KIQ(offset, value);
        else
-               WREG32(offset, value);
+               WREG32_XCC(offset, value, xcc_id);
 }

 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev, @@ -1095,6 +1099,10 @@ u=
32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        if (amdgpu_device_skip_hw_access(adev))
                return 0;

+       /* Select lower 16 bits to read in local xcc */
+       if ((hwip =3D=3D GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+               offset =3D NORMALIZE_XCC_REG_OFFSET(offset);
+
        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false, &rlcg_flag))
                return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, =
xcc_id); @@ -1102,7 +1110,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *=
adev,
        if (acc_flags & AMDGPU_REGS_NO_KIQ)
                return RREG32_NO_KIQ(offset);
        else
-               return RREG32(offset);
+               return RREG32_XCC(offset, xcc_id);
 }

 bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev) diff --git a/d=
rivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.=
c
index 88b4644f8e96..5bb275b96e6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         */
        if (adev->gfx.kiq[inst].ring.sched.ready &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
-               uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;
+
+               /* Select lower 16 bits to write in local xcc */
+               if (AMDGPU_IS_GFXHUB(vmhub)) {
+                       req =3D NORMALIZE_XCC_REG_OFFSET(req);
+                       ack =3D NORMALIZE_XCC_REG_OFFSET(ack);
+               }

                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
                                                 1 << vmid, inst); diff --g=
it a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu=
/soc15_common.h
index 242b24f73c17..9ddf68e7d06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,6 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + =
mca_base + (idx * 8), val)

+#define NORMALIZE_XCC_REG_OFFSET(offset) (offset & 0xffff)
+
 #endif
--
2.34.1


