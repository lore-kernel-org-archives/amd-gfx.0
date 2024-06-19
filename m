Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB529C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 09:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6741C10EBF2;
	Wed, 19 Jun 2024 09:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1cCqjsX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1458F10EBF2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 09:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHAbhAKHhhN+O+4MJxmHN4/veolLMZ6ZfKwswfIIa6Uls14RoMD71CQobRg9OqOp3kgfHnSP9vkbFpef/FYKF4FW77yeru//nHIHMloaWi9w6Ky/LGuVDZqD6lfzOjuCtf+EAkpCr/6WxIeEkJwysa6/5VCqgzbOCItOqo1W8kCCTiHvgAkQgd7FGHfVVDI6CTUaoy2FvxfVd3+v1d/i/RIRv9ofWkcbSzajdOW8tx1lc435lukKq6A/1TpV95SiQEylhPsrof0g5iFXLMP7RcF/MpQvHbzmkWa7b3RWvpREmAUIjkKwtdhLg93Ne9t1OPhjbao0r+v/3nxnnZGXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwq7+6bk0en5KtBVV2R0ryobFHzkW6CRXsbQK42nEfc=;
 b=DARRJWOEgaKSUbABN4hb1ShUDNAPA1m5Ry5CEYMpljuPSkTZV4IlLPG9kyY0NlhgmD7gqs36kyUcqexs6Cb7+5CVDNFEU9BqRhhEtKFdFugnGN14peeQaXldbI2hS8v8Wtq2hZcDTqE3k9UJ7QRoYN6d3S1AeZdN3+DGlbGK1NmBniF/5SDGxr4eX8yFg/lA7fM+5QPmK+gqy7phIRfoKWqGmjc+fwKAOSZbeEiv0SqFxQVAhNE4CAW9bt7kWcaRe0MX4mFEW8nxSUTK0DrD3blX9CRzhWUukohGSqK+OH5cG3KaF1gKrf1hMXWFykaLdxQkJjc/xTeI68flbPHeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwq7+6bk0en5KtBVV2R0ryobFHzkW6CRXsbQK42nEfc=;
 b=k1cCqjsXtiQsuQLINdh1kl1K557O4ungTQ7tWysTm//hq1Sl8f7VfSr5fUEwmT/+G+uUwgywGLI6BG8716/xJvQFPZCmRF0mB0qr9pqfNkxJz/YDf9URQrwtFOqzIMC+a+adWjHBGa2XJgzUxn5/RLHz2JC100ucIllZ8HbZASI=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:58:00 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:58:00 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma, Qing
 (Mark)" <Qing.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Thread-Topic: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Thread-Index: AQHawi7SRBRnpvaknkunCKS7J04qC7HO2I3g
Date: Wed, 19 Jun 2024 09:58:00 +0000
Message-ID: <PH0PR12MB548122B7E357C13204F2BB75FFCF2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240619095526.1387723-1-Jane.Jian@amd.com>
In-Reply-To: <20240619095526.1387723-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=71481e95-1319-49ea-901c-d1b0a953a608;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T09:52:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB5606:EE_
x-ms-office365-filtering-correlation-id: 72fd1171-82fa-4444-7512-08dc90464dbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?krkeG5dUZLl+Q+6FP4LPYaeAf2kv+eCdvRerruRHOm1k6IDy68PCYM0ADryY?=
 =?us-ascii?Q?nlk4OIpexvHKotrXSBGaz+puA52JyWWihMymsLRFCmhwviljQogY7kH2meZk?=
 =?us-ascii?Q?vFdSoFJeJEHuZmvnElAPgfXa4Y9/LIzqYyC4RAmzjztDv6ejPDFNVZs1/055?=
 =?us-ascii?Q?uKWdqhnCIa2pmg2rHZ2O2RHGbG0s/BQ7ygYDsdwDNDE4Rh+/WCoZ62J8vqgC?=
 =?us-ascii?Q?vDwHzjioi2SDD3ZEtWpRzMjiPSLkTyYYSonk7gyK5o26M+1D+zhaQscb0RXe?=
 =?us-ascii?Q?W+gBDHP9BdWdfOHBxRn3/2tH42tUKofzG6zvyUlWiX/Ve8Sw9YpVLelMCB74?=
 =?us-ascii?Q?2rkqvZ8Ev5MUD/3EAHOJtq9SwFkg5kLXCG07oaec9D4g9ihB+31Idk6nmHCG?=
 =?us-ascii?Q?t+MZYjYcrxdHZh67K7R1H8dFVwpoMMGslZYl0kL+5+H/nlDOr6IWZd5Jyh6l?=
 =?us-ascii?Q?owx3L7W85Wr1YmHleef+i1Ley0FINkZhV5SkQj5Cg9fWtHVH9F5Ngv1/s5BW?=
 =?us-ascii?Q?mJ3N2FiC3+tixgc9Kj35KUGN9LveAldERghtVukw5C9Pose+QWn7jE4qfO6Y?=
 =?us-ascii?Q?OQP5Y+Kl3mPqFIAoy9a0OzG8xllc65Rr0wBfe/BwQpVZcY38Wo5e9b3jWvQD?=
 =?us-ascii?Q?HSIpkU2LMhqL6Q5seHcv3fxQk8G5rHDzkvIash4IyokmpGFB/Hx4fYcJWt3+?=
 =?us-ascii?Q?P1XGgHUECQT7HCEJu3ldkQjjc+Was3lZwI/p6xcWZit/ZqjNitVwGZaUprJ7?=
 =?us-ascii?Q?ckRStczL5nHV8YzIppGmb8wvh01nHjygPWXBx2DAHLG634TSI3ilSV/WcT9z?=
 =?us-ascii?Q?ji6Carr6YKpYtakH4n8KmyFBhR0RwbWyyzhyg/9Sv9arjpixcc7ggT/Z3gY6?=
 =?us-ascii?Q?7kGkn8IGuFWdrNaNINauEsCIo4cZMTfvsibsHfldYmZ7F1L1s81d2qNLVdGD?=
 =?us-ascii?Q?gFwwr1ffa+aIY9A/uNWvN7g0fLeiOESfVmRFPNEhhoIytQq7txIeIbDUIzDg?=
 =?us-ascii?Q?Gl+f1SVd+edevuxECSMIhKSnCbnlOTfBSvnfj6P8i2I/yibRQLBG/wu3+9BQ?=
 =?us-ascii?Q?Xn/oFyAtzeBIkFun4hKtbbCugh2i+XoRup6I6KfHF/r8ymbCeSDyfgDay/WO?=
 =?us-ascii?Q?dnoNTvOrnC0y6FPe4vUnXE4md4t7zDphnA8GEbJ06JimwjCabFwZwwoGLy7/?=
 =?us-ascii?Q?tydXabDG/mwZGbXtQJknG05MRTyX8vdoSckmiXyy+mPDYP4j6e2iyX4RJ/mA?=
 =?us-ascii?Q?KR1Z2Mhfv3FrAWrVhLowpzvAdFwWWkkisq5poCcOPMrHdcOeyZ+pHo36+qm6?=
 =?us-ascii?Q?J/ZDi7JL/cmLAiwXNlK1wYO6sepeGApX/+EsSnMSuSRW1Q48GZLHLXSJfT16?=
 =?us-ascii?Q?kdzhv8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l5DhAsITnCZ5Q34YawiA7knNLBN5Otl9RIytNsEqhkrsu4IBL6icAnI6PITs?=
 =?us-ascii?Q?E8stSpdPX/koF1PnvHpzrZnhDXSCAnEzYxr5uFq9eV8apwkQbcyPNwKD471s?=
 =?us-ascii?Q?ub0imYe+n8mh+xyo+a9se0eIwpZsE30QLZdoTJm6cAl+PR3yjcuJY8iy/fSx?=
 =?us-ascii?Q?SAJ8f/xinAD/3Ih3XW+hqhXMIZNFw7ifSA69O2/GpY5FM0Vxc8oEO8tYZYGX?=
 =?us-ascii?Q?uzbgyiBCMI029VF3gHS9nXq2+dMulW9dmZemphB8tyP1oZvRqqwppsxgCQ4J?=
 =?us-ascii?Q?8Vn0ZLgbr8KE5mwZqPWajPThfSNy01qr8Uh8BZpgPAu5yco/Et2N9GUO9maO?=
 =?us-ascii?Q?e16FY2KChDuoj0MJkZbwPM91TuPug5PP1zkTKWXEbEklrX7tIVlxW6+XTuLb?=
 =?us-ascii?Q?+kMWtumf0N7mNML942vO5ida0JxWAa4m8WRn6zUEf4zJhWMIqM4gDRSQLIk4?=
 =?us-ascii?Q?Goz7fTrkqZ13UFM5TGrydKjA6V8oS2gtwvAO2yf0BsXkVY8TrvOEkNY5Z9lO?=
 =?us-ascii?Q?2LrLjXipt32hS8lZSXBxD/SojZUrNs/3d4LoD4BGA9wzdRV7PpbEy+uyRFuD?=
 =?us-ascii?Q?x/CxYsqbSZmUY8V9W/twt4cgUkyJ6HFMCJLAMyXFAzfyMPKfHKeQsyhYd/P3?=
 =?us-ascii?Q?N081qEUlhjoHZrEzDQ9g96pUvcXGWLzxLE0nlHvggasNlZzmJfs0nN5DNtZL?=
 =?us-ascii?Q?QSeTd7Tq5aTN+3gO9S9ELAmcXUv9drEhlpz5hEeQ8Ovr/kJwwetT8gHPIfQT?=
 =?us-ascii?Q?j4bZgO5nSJ0on2nwlliyFmVJgoykWHNOXLGMDyg13Tv/ZKBz4JlUNzTOPRc/?=
 =?us-ascii?Q?Ks0mYmG629vHvjvMO3N/+dUYFNEqCU6ZWmM2cUZ5pCGwvN+AGaI3g40dxUA2?=
 =?us-ascii?Q?KvAKexXqO/1+QbhQ2PsXzyPYuZDiRygCXgTSeQz1CeeDyoOa4NZD6l+G5DV8?=
 =?us-ascii?Q?4t/AKhWMbOH1WuEdqWwyVwv4U5525b3mzO8e5mrgwB8k/f5NBPpSnuGMYTQI?=
 =?us-ascii?Q?rUEdM7R7YreMDbVtZN8gZE2QepGbNDStRTaB3+vBYXw0EuGXJU1xmvaaumyW?=
 =?us-ascii?Q?94lSaLJFQLvrK4Y73BBUY/xE81Te/e8lDr2g6zzeaKLZ12JSYS0T86fQATFr?=
 =?us-ascii?Q?VqOj/Hat5/JlSp8ke+jTiXNVGSw3k/HVC3CkkZodjFMm+M5TXCjrLTV1Kmm3?=
 =?us-ascii?Q?nbwn8RQv7T5mZZpYrcQ/YHNlFH+zcoVfsBit19/2SlYj26/pe+d9QDouMvJi?=
 =?us-ascii?Q?93osfzOqNapAOaGF/OGQzKnWZUKXoXeehnrqRYuK2IzG7oC03z8irqFsZFnx?=
 =?us-ascii?Q?TSPi4RH4lQzXQ5ddOaU+UuoS2PZ0HbWG1sd/5quKnUBk5uOCNLKVQhRA/DmH?=
 =?us-ascii?Q?ugQ/rUsb07n3KCdasRcC9C8JdwHrm9XvtA40tZuamaTPyTPN8j7ha8gLXO0h?=
 =?us-ascii?Q?RgPurudm5pgRvD7tYuvulLdJ3iyptBHxpQby06SnQX6dHVvxJ3pZD7clXr6M?=
 =?us-ascii?Q?Gk2+aVttDeG8wh7WNR27JnwN0zZCqXkVbWWZNo2ylQU+LTXxhGWihzK+a40d?=
 =?us-ascii?Q?mVK5eaSlZGnrqa/XYcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd1171-82fa-4444-7512-08dc90464dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:58:00.5538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9BTWl8ZcLuZpxqM+nbV46UbXmXaxPLmZZJCg5xqYa8/9LBtpkg2Bih5hdS7RWyJ6yEq2rpmqV/DnXKA/LzlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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

+ mark
Hi Lijo @Lazar, Lijo,
Please help review this part I patch.
For sriov read/write part, we find a bug while masking the offset, which ne=
eds time to debug and later I will submit patch II.

Thanks,
Jane
-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>
Sent: Wednesday, June 19, 2024 5:55 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to r=
ead/write under sriov in TLB

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher=
 bit violation RLCG will mask xcd out and always assume it's accessing its =
own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  3 +++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 083f353cff6e..da8d3669cc23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -632,6 +632,8 @@ struct amdgpu_asic_funcs {
                                  const struct amdgpu_video_codecs **codecs=
);
        /* encode "> 32bits" smn addressing */
        u64 (*encode_ext_smn_addressing)(int ext_id);
+       /* normalize offset to keep in lower 16-bit */
+       u32 (*normalize_xcc_reg_offset)(u32 offset);

        ssize_t (*get_reg_state)(struct amdgpu_device *adev,
                                 enum amdgpu_reg_state reg_state, void *buf=
, diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm=
/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..3306df74457b 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,12 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_de=
vice *adev,

        return size;
 }
+
+u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset) {
+       u32 normalized_offset;
+
+       normalized_offset =3D offset & 0xffff;
+
+       return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 88b4644f8e96..fba2e4ad58db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         */
        if (adev->gfx.kiq[inst].ring.sched.ready &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
-               uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;
+
+               /* Select lower 16 bits to write in local xcc
+                * for MMHUB it uses xcc0, NO cross AID reg offset
+                */
+               if (AMDGPU_IS_GFXHUB(vmhub)) {
+                       req =3D NORMALIZE_XCC_REG_OFFSET(req);
+                       ack =3D NORMALIZE_XCC_REG_OFFSET(ack);
+               }

                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
                                                 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 8d16dacdc172..31037f068902 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asi=
c_funcs =3D
        .query_video_codecs =3D &soc15_query_video_codecs,
        .encode_ext_smn_addressing =3D &aqua_vanjaram_encode_ext_smn_addres=
sing,
        .get_reg_state =3D &aqua_vanjaram_get_reg_state,
+       .normalize_xcc_reg_offset =3D &aqua_vanjaram_normalize_xcc_reg_offs=
et,
 };

 static int soc15_common_early_init(void *handle) diff --git a/drivers/gpu/=
drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..0d405a474283 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_devic=
e *adev,  void vega10_doorbell_index_init(struct amdgpu_device *adev);  voi=
d vega20_doorbell_index_init(struct amdgpu_device *adev);  void aqua_vanjar=
am_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_xcc_reg_offset(u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h
index 242b24f73c17..43887836377d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + =
mca_base + (idx * 8), val)

+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+       (amdgpu_sriov_vf(adev) ? \
+       adev->asic_funcs->normalize_xcc_reg_offset(offset) : offset)
 #endif
--
2.34.1

