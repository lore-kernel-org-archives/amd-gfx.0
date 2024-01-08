Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC8DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 04:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1BA10E08B;
	Mon,  8 Jan 2024 04:03:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810C310E08B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 04:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5b6e8oo+z/bEtYgrmJv+ywnd8rFntiW+z8+EQaJzQZc9wkrFXNedHBmiE0m+t1//fVIAFDy1WDK0icKzOEWwqwIw15Dvg5+Tt5H0x5id2dLUOP9D4iGsSyazcxn8fPUnl47oLe4+Wc4txMkyRh1SKKooWEXMHREM2f+8a/cQtd8kRvHbjBlOLBMH1KP0xWv+CPLsOFZbwPUu4VmIDLFmx7Wqzi762J8L/eKjQZW62X8tqMMmKhUf2PV09c7GmnRYsVPaVt4k5MIkhSM+L6uvihH0q3Ekd3kfurMboMyYnlYvysWNlT13bU2NJnLRcmkwNz5GyRfACt6ZyvJTTBhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIsTZcKWvoKOfq+dj3mE2cgi+/aZfeD51O483H1+WeA=;
 b=SIXDAxdMzoTJDQDkhHxSK5068vvKFcj9HdwOUAcFPtk6MrkfP7jWN6z+TjGzwPpuiUsIYNDDa8bLGwIcTerb7Ta71kvNQXtw6QBYBnenCSt0rxmb6qp1ak8rH24u+Z9NxcPI+qJchil3EOvbzcoTolKiJ9uUNxli90iJHUzi+PqnI1DRTpFPg77zuXT2L65T3uhEMUxZJFdmxs/OFL8lUB7rMSmMRs1ayYItcWCk69IB7lg0R5jb8OEsWCqeVyCFuZTFax6bDxPQ3Z79RPgCB1dqL20kPjkJXDknjbUUjD5Fb7nMJGRH6w1vVJWDLSRkHqUlIEVvVRkLxcF6C7Ac2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIsTZcKWvoKOfq+dj3mE2cgi+/aZfeD51O483H1+WeA=;
 b=bbyHXPr1u2SjYRLogluJBC6jyhhMRwSU6/spGWMb/arMoFb1sou8Be4dfpMmltVSpIi146F6iwMtEWqJqgm5uDw8ixqvtL3bbQVtPgnEhaFZWnnZ8+ANpJCeHGFpc7fZ4bT7IfonczMfFtOsfubgONq3bAmd/5PdjuVKUHacFtE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 04:03:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 04:03:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: correct the cu count for gfx v11
Thread-Topic: [PATCH V2] drm/amdgpu: correct the cu count for gfx v11
Thread-Index: AQHaQeFRaUEMLqFzH0etopJY2/QugLDPQjWggAAJKuA=
Date: Mon, 8 Jan 2024 04:03:17 +0000
Message-ID: <BN9PR12MB5257BE23991B8D302046FF7AFC6B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240108031752.3897754-1-likun.gao@amd.com>
 <DM4PR12MB51816E07F4B21259693F789FEF6B2@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51816E07F4B21259693F789FEF6B2@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c4482dd-8f5e-49a7-b84e-08e37fcdad42;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T03:30:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6619:EE_
x-ms-office365-filtering-correlation-id: 51379013-6ace-4af1-1880-08dc0ffebecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNLrLXozOaiCNSiNzvvtatFu8B6s0bei8mHUbNetE5r4ft/zffYON9xHV0jsjrAb66buHE1ahoLACLt2hC2j956OQNlN2qaUTlLWXHatZEjVG7r2GJIDFogSHoxkDZLW+vlb+n+6i0X/89hT/rOaTab0CrwdBup8nwb0HE2q1GPYslmmTCXx7zWXnMgiTAy9xZBQSxXXD01atJjrsoBCAh5nqiXyaar7iwFsmKdoDPcR200iJOt/u3P7Ia1o/DHwJvCYDEWp+oSXOZzbY3cJQQY+xM2N7QjJkiFBWvGCINN5/FwkHA2xRhf+WlywA7XmGECTThQSUXl9K+aqVczSJr17r5tahKKVRVtFbXT5J3E8m5guaPgTePm9vhfI5yTnttykUCqR/J6G4woXGgNmFYwTzsqJhCFfPj2djgtnvFEQ74510OzSIR8qnJcoWn2ol1KL56pjTZIZ/LF00ZOZHxZpRFnVcanAdtAqvfyZBpG+qOTms4mDg0xv7kVf57e93ndSple/YQjRhotLLExzVdL8TlxIg96CwwOWBLm4xCQps2nbklivT/5q7nfl6volAxOBTXp+sZTKuC1UhA9V0ftFJVFwkbnmLPKZ9wDaGw4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(122000001)(5660300002)(38070700009)(86362001)(41300700001)(316002)(110136005)(8676002)(8936002)(9686003)(55016003)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(26005)(478600001)(7696005)(83380400001)(6506007)(71200400001)(33656002)(53546011)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bIlKySRQPSB1UR76xjxytytxJdxBrfK9ch19z8i8UVSUnk8EflRsKkz2Qm5B?=
 =?us-ascii?Q?1PN3/0ul+rIWPiL2Egf+6P+5u+2GnOcwtjRgDyLdgOsIuuwBL3ICAXsehY9L?=
 =?us-ascii?Q?PhKdMaOqz7uG3/TyPQzExBHf3vpm8OrcVwkVo4arPpdd1/NcHQ3w5uENWgJt?=
 =?us-ascii?Q?N8EFIr6T+3XRFTPboHKXZxgKzrxKD07PDO9nuUAlhlbVgzwA7kMGlETekPAJ?=
 =?us-ascii?Q?7fwLhJCgW3lcXsKbYNZ6SzQ8EznySjYFdW6+vMRIpsrfU7NYnmTAL73yjJPp?=
 =?us-ascii?Q?M6mz7ouxWO0L3/mk+2fqytPzQVmke9uX2GLXcqr/HjsZTZOrgJxtwUWYPCgp?=
 =?us-ascii?Q?71GgX6DfjRIOZiwOJfKgTFQJd8+M4LQBqRdAmBNr9u5/25u+dh6KaAQZqzqW?=
 =?us-ascii?Q?L0gNlA0+g+UqhzkvtMRJYyirr9xLqPl2FZ169sYPhJQcMFdJDLc5yRsvZZ3F?=
 =?us-ascii?Q?cSGkOwPUYyrfPFYXcNmeds/eMMRST2U53d/O1xP6sbPaEEedelPRN6BWuBnM?=
 =?us-ascii?Q?PnofgthGS4Ekb95I0MNNqtLk0K60eihJbQrjK9kYpeDwoWOwDw2NpEOCOlby?=
 =?us-ascii?Q?G6FVdLpWg53BeBMqkCUYaZ4T1d5xkGgxPMu0+BsP7JLP1GlVxVNpE1MzwE/h?=
 =?us-ascii?Q?PAMDfFChUydCiNylGFQgFbNhXwbSxhrSPSDTSGB/av5cnpIERj4/ld/z9pHJ?=
 =?us-ascii?Q?IoSVpfc75ToEEI/Y2xK9XyxHPkcqacjab7ZoYIOdL/u2TAk9pUPEoYI6F2k3?=
 =?us-ascii?Q?cGmphj6hQ2Rl57uL8o4XSdMhcPxa3Wr5YkPErBBBFxDUZAFFtieeeK56IV9E?=
 =?us-ascii?Q?crloJGQdBzoMwL3ueduyg38yEb8pXhgswiXiqLDvAzVuJIt/+vDrwQqxon/E?=
 =?us-ascii?Q?lIxFyhoolA+xJLciC2T81ftt/hp3/C5MI4Dz6ZmGlzi2bLJW8ku/LvkOlyfl?=
 =?us-ascii?Q?c+CT+/cPTo0/IbEe8aGRdelbxI935gBQp3axYBmASWwKzlAwI1y1T5lCBJhn?=
 =?us-ascii?Q?iqpBEVunF//eo7QRlC/0jBNXDJIAZW8bATGwl/QKSNkbd2wLjGovIEM2Er72?=
 =?us-ascii?Q?qrYEvxaJXWb6TMd9fITzSdytumRnkOCuapiqpWoXTNqMjFWiuIOIWSjo/Sna?=
 =?us-ascii?Q?65mwUqbTmP2XB+iW7OM9jdloEQoyE4eWL4iefzAbpY3nI8IsYhJ3bOz7J4f0?=
 =?us-ascii?Q?v2ecOspZbiFBdx7sbcRCx6I3bQV/wd6shtTg/B3YpYj7Yo8lPTxPDpZ9UG2T?=
 =?us-ascii?Q?BUIDsCB2Ay+haL0Ld2St6DcbDw/1yn1tWvHHDrPHepmSixBbKIMX6Rh4eptF?=
 =?us-ascii?Q?GEeQK1RtVwOwIz1GuLZqeM3RAxdBmJEvvCmDhhGwyvhkjPcmsVRDYbUN37HG?=
 =?us-ascii?Q?AEBOSdkoVt6G9zdPCIJ7gvCDWQXmK/Vaq5Po1d2IPHR+LL5MzmVPgwdjcB9b?=
 =?us-ascii?Q?tcrSYj7LU1liaHFUKxbV4NZGSHcF2GmhDHH0CsFHlXEj0ycn7ETvnouZG0ZY?=
 =?us-ascii?Q?+3w0SM7St6er4ZFdM4cpdtjmA/BdgfXmFkqJsSkFiRP01roTFU5JUQtpktNE?=
 =?us-ascii?Q?mNHEOBEsT4weON11idQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51379013-6ace-4af1-1880-08dc0ffebecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 04:03:17.6893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjcEWEQO4vOFCjt0RY1jGh62VqhTjhHFx8ynVdRawv/OLiaytWx+RNoBhqXK+gff1M3+WDhEB3n1rdeXszOGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Monday, January 8, 2024 11:31
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: correct the cu count for gfx v11

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Correct the algorithm of active CU to skip disabled sa for gfx v11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 2fbcd9765980..c7242877d5d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6383,6 +6383,9 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device=
 *adev,
        mutex_lock(&adev->grbm_idx_mutex);
        for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
                for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
+                       bitmap =3D i * adev->gfx.config.max_sh_per_se + j;
+                       if (!((gfx_v11_0_get_sa_active_bitmap(adev) >> bitm=
ap) & 1))
+                               continue;
                        mask =3D 1;
                        counter =3D 0;
                        gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff, 0);
--
2.34.1


