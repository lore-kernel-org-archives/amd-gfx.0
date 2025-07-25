Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C5AC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 06:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB3310E9B9;
	Fri, 25 Jul 2025 06:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlwHHpya";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC6010E43A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 06:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6Jvan5mZP5QZFf93Rl/dPUMDMCVaLdTjcYekBIhrnkGzAZ/HL+VfyZyZT500Qxme8eCvKedjIkA8bmkL82r0BNxrxqkBa/+z0fDCBnpVQ/6//obK4hCw3st30EqzhGHBYR6LmBChrlg++agXNVLX+0//haLGYetawO5E4xxEs3l/fvid/kv4/VBfQa5bTK2FY7bbD8ZT/C07qHpXwJNl3mh3qzbEk6RAPCKtxfbNj+Aem1HRYJ9hzlbTEMbJUkggQAS4un+ExpCztVP1YYHFEom/vbwRyCP5ClmecCrywgiVYbfrOuD4lg3ACHh7QG2tRmybypGOcrHmvIDDuvT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MimwbHOt5ae9Z1LvUHX0c2Ccqfqz3mrIER8u1cmryYs=;
 b=ygFLiVi/F3K0Jwd/uaAtnKvqF52JXEi66gHDgBYPYnxfOmX6Vw/seRILlBFmen1PllPpo+O/aWHyCRFobHPwkA2ocijssRol9FUWaCRvkz4qBNEDOzMybnaV8TnhCKNjavjiUcSTPTg9M9pPq9zLFaj6Y4WoAa61uKcEveMPWgB9m8Hozq5sMQzPL7kJrqdQ02akTyj42Ust1IgA59PfQSmkJupRPReaMsV/h4ruTGgltyVU42Fv+zbbcR1klHrINA7n/ODaWlE26ppBQjWkHZqtzzk+m5Mr+j5jSgXLiYcZitwSZlLqjNzo40/vlv9zGqwxl4J7zWtP3yWrrS8PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MimwbHOt5ae9Z1LvUHX0c2Ccqfqz3mrIER8u1cmryYs=;
 b=mlwHHpya5hZSY5LE2cYKCI5NuY6dh7khaPLcQaFsXPE5JkTeFVZSBuxPPm4inxVRBoa39D4kaZCufZMyx7Vzdq33kFWCusStiR5txaQDLvqlBluxDDipo0p17g2NFn1BTzB+XGKrB4WlILYuVq6zidnCEMUKZK7KoDvLPeP+OUU=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 06:25:09 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 06:25:09 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update external revid for GC v9.5.0
Thread-Topic: [PATCH] drm/amdgpu: Update external revid for GC v9.5.0
Thread-Index: AQHb/SjdYcGD98/GcEuS8k+LJ/40PbRCX2PQ
Date: Fri, 25 Jul 2025 06:25:09 +0000
Message-ID: <DS7PR12MB6071D7C9D83277EB27BE0DB18E59A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250725055601.1637428-1-lijo.lazar@amd.com>
In-Reply-To: <20250725055601.1637428-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-25T06:25:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH3PR12MB9022:EE_
x-ms-office365-filtering-correlation-id: bba68ab2-d45c-4f6f-9b0a-08ddcb440151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9c09b16RG0+ttPPRPdO8G4XVJqJRqc8hKKhstB+CzK/uPFFyxI89Ih1YlOTI?=
 =?us-ascii?Q?TnEnC/V9uC0TQdhYUnmZcDwYdTYc1U4kPq8VEBtm3BtNXpX3NxyKKoKxPXiW?=
 =?us-ascii?Q?V1KIYeCxLZxsnf1yu2Hj6mdtpAOBEAqKzpJtzwLF93rXSsIwCAj8E0AVd2HF?=
 =?us-ascii?Q?lyoZbqa2Mddq/3KbfSmGMc6R/Yav0JM2tsdklVpYHznQrDuMhZ+c7LYOAK4d?=
 =?us-ascii?Q?gg+ZcSYbp9yVv8SocLxls6DW3LVL320DGCOcrRAe9TAbl6IC4PyHsZT3PKGs?=
 =?us-ascii?Q?uTkYZLPogOIhqs/C1bJwqPQfZIokO/1Unn62aPb7F/k4EJkSPRok2kkugmZL?=
 =?us-ascii?Q?0EmZ7NFRz9Zdn1qxwyt/72DB3477tXgwdRd8qkZkQKCtN/hiHBgEIFO5evKZ?=
 =?us-ascii?Q?FvKHa25ubzD3q9riY6K/t7yJinzJNnEEUMq2hg+DLlOClAyePF55HPcvuEuo?=
 =?us-ascii?Q?CjizY2srjbsNCeeuvmIcPcMhvB4fK9J9NDEQKMFAlwialqoAW5k/LLe968F6?=
 =?us-ascii?Q?/3wMBcpDvqcOs2Y+Fz+LQJv2s7NHPQjP4EzfsSLTliX2aHynm+4VPmrd2WJ9?=
 =?us-ascii?Q?No8i+CB1rlEW+43Hv9QzHunFSDoO/x/Ih7k/k2Za7071ScRzeXIjsbOBPB6D?=
 =?us-ascii?Q?TxPfD72xqndHU2KYvPOiL0Y60XPohWpgCNZ8SdynyrV8C9iPO4oRouLRrbLc?=
 =?us-ascii?Q?QBC9MsKafFCP41qYcGh8kL4FwnazbvVqEzgpvRDlz+7rBIwBL4iU20Pc3ehN?=
 =?us-ascii?Q?z/swb+Hydk4p22rTMVzymM4TY2ORIyqbHVysPLy2InffJwVyKFNwuUYMhVRg?=
 =?us-ascii?Q?DcEUjLHqxzBbDHZsQ1BOSSr9stEQ4q8ia/9KY8UErDRWVqmeCvK0E+QKmmDE?=
 =?us-ascii?Q?CniKDA29bjQkvJa9Cpik0tifHc4p+Xp8wTN0/E4YAAwKCjy+RBTIhXOZDLxv?=
 =?us-ascii?Q?axiyE9UI37lLeINiwN4wkS76LH6OT377H/uV5S7gbrfLGiaPVnDNbTTYUI40?=
 =?us-ascii?Q?EKqF2wbxGPaFPWU//CDuKWg3EcvBDEvHyFPP+F7ocwLBI7JSdmNKHsZqcrZL?=
 =?us-ascii?Q?HZ/dkLYNPEdTT8z0qM+FNZJP+eQbw1AqtHozePctWIqvS4LRqqm57qtLAnTb?=
 =?us-ascii?Q?2QL1NwbXMkqocva9FPDeuPAl7M/SXkH6a8///BSzfVxk5cpTWAVsEXIhaoq3?=
 =?us-ascii?Q?ZI/saU+cwZhICa/Iyx8VIfHI6MaKFdFFCr19qQQkYyKtV0Btz6ZA65Azh07F?=
 =?us-ascii?Q?m1zS//SzKDMFL/QMWvrseFqqtusaNmaXv6l8pFrv1KDS8nj/zhD9/XKTimQA?=
 =?us-ascii?Q?evquXR45v3qHDJacOHw7MUpllm5uJb68Vi0mmgi/6QpXsInsnNvxghrb76ob?=
 =?us-ascii?Q?kaS24F+2mwv9pHZSpy09tUSEhQF3jfpFB+04Ur8DO3N+fIAqsZN1ctTT93Mu?=
 =?us-ascii?Q?I2WMLQQL7QPLrIDCnNvvYuO9Mr/jjD9A/cyFQidzAujhOdtOjLI6FQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?evIZhE+nFYnMxJQ7JpKQVSXQao8Lf2RU72A9AA0cIDNsGvjru2l5UTZ6fzlF?=
 =?us-ascii?Q?mpdrHojEiax5YOrQN8ZR7qM7sYIMysUZyiIccPtpbMEgWEe1f2jbZr5aoc3V?=
 =?us-ascii?Q?vlQ4DNwKJogOVqQDebyb1lERjg3oUEgVHBqF+HJ07iSjcarBM0g+HLdIAVxz?=
 =?us-ascii?Q?Q9VbD674f/DdT7kRRrOo5MasBRy1mrv3yvqGIbvSZC66+VI5iekcWAvb1Gsg?=
 =?us-ascii?Q?Y5Pkp/J9rAHal8NWur4cBlZ+nCZNYsIYtpxfIpIf8JDqGA3ziRiUQnZW91pC?=
 =?us-ascii?Q?xvKsiGKO2RH76A00lvCxk1hxX6QmNlwSfc7cUKMIw7EUsVr3lIMvCN2ph9LW?=
 =?us-ascii?Q?6fQmRmcehMg6Uq/zX7kncPmuQds4irvQ4ajgXdSASbMJ1d6YjI6Td0wZ84bQ?=
 =?us-ascii?Q?F9b7xxVtaiuJsmUjVPs2wpn9RB9+YoQzFaOnu+3lIfyWl1SzugeDV+OVmien?=
 =?us-ascii?Q?TfsGkrykBMyhmdVvPZzd6Py8R3xZV4qYmqVSDNkg6BHVlSdY/N5h23M3cid/?=
 =?us-ascii?Q?MtWYaF3zP4qleJarppZgACMwJ28ybdqpa+3be02KQKHTrzFMWh7K8Iry+hR3?=
 =?us-ascii?Q?opZvbW6UKCs0iuNDtBG5GK5bJS14YUG9aLTVa62a5QLutuZS+avP3lsOWD3/?=
 =?us-ascii?Q?vKYfOiTnZGtVb63CUb5j1uky51zDxXquff//HDn6I76Z7VRUiSwD/hAqvnkB?=
 =?us-ascii?Q?DJ3CfBXQx63I5gFt76pQQfLWScjeqxW9qWDEWAKs9xgqkPsJqzutovXOLwue?=
 =?us-ascii?Q?MEXbXS4y+45SwFkma3h3zDBSh3rzlP9P3CdD4oCFvbCw/YevPhkFpPgHzYzR?=
 =?us-ascii?Q?fAFFLdQbO4ayCvnmtlzuKeAJvN4oiiPgLzG1zeZXnMGDaBbrG88RYt/MIHDB?=
 =?us-ascii?Q?OZaIOEMFNRdlmfokBQbkw9YB5i4WDoNW9iXMxEaGHPnCXleYZdG6wXIsqCMf?=
 =?us-ascii?Q?6srstAxbmptI97CR/2wkGaXtbla1eajMdDA3eJk2tYQAQizRVT6XbARQ7U1y?=
 =?us-ascii?Q?1GDEqDMWlMO01zz2wHLb+r+7ByweZ1Akr28G82rXOGqP4oNLyXXroUH4vKKu?=
 =?us-ascii?Q?TCd4v/bT/YOcfS0rnbqwkp9ao4u60pF/7hhDFj73xJQOBQ/t+XhjNknUHQDA?=
 =?us-ascii?Q?qGbTZZ3QTT8nwpHhdqSYRf3czwLFww9E+L2Ztsf51LD2FWiSRvEGDNr1/md7?=
 =?us-ascii?Q?59nRKekG9+Axn2j0pQ6eXfjZd/sum496lpEN6QzPBntsz8RJ1l/13/0D2A0K?=
 =?us-ascii?Q?8Z5QVMytLuF6hXMnuMVR2oSBjKenQx4rBvOpC6F/JPGlK8meFi15B43CxWMQ?=
 =?us-ascii?Q?gahbOtrElFEH83BIqTPXZAe/0+/mdjcpr1NjNmMxzJTjUHQWPGLk6QIbHqic?=
 =?us-ascii?Q?3oHM0C8YIEFemgZ4vYLXiRTQWiWh1p/iOQnPMoN+0h3ckCW6lN42G2l2Uv6C?=
 =?us-ascii?Q?dBOqMn5G9rEuS6DgqYjFe8gkQmJoxBWkxS5gaai1UxPqrIWGO7F5yZEE2nOs?=
 =?us-ascii?Q?/YnDVqcMQbrZNtzM8UNCVcBjFna7mz/uyOIbV85+la4WvoGCyTDO0XUPIDc1?=
 =?us-ascii?Q?9F4wGn+WE/xn50BfZwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba68ab2-d45c-4f6f-9b0a-08ddcb440151
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 06:25:09.6467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwGW4PKkBwQa9wRcVXNRUjTT57PSaA8xadqNj7NpuGuYbPglNWdoEnj4nW58GzA9e2gIPrETj/LM4NA7l/tCNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, July 25, 2025 11:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update external revid for GC v9.5.0

Use different external revid for GC v9.5.0 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c457be3a3c56..9e74c9822e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1218,6 +1218,8 @@ static int soc15_common_early_init(struct amdgpu_ip_b=
lock *ip_block)
                        AMD_PG_SUPPORT_JPEG;
                /*TODO: need a new external_rev_id for GC 9.4.4? */
                adev->external_rev_id =3D adev->rev_id + 0x46;
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 5, 0))
+                       adev->external_rev_id =3D adev->rev_id + 0x50;
                break;
        default:
                /* FIXME: not supported yet */
--
2.49.0

