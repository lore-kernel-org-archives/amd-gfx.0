Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC14C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 13:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24068EEEF;
	Tue, 12 Jul 2022 13:29:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB308EEF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 13:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VccPr3OLyKziEPx8O41aijl17eh31k86Xq7pglXU3nBbjz47d1fe3N2v6EFRB6BC/1ywUooPOLpYxqkDn3R7A9hVwljHxNYtHt19WhrEvlapBtT8+GL6LQ4QKySR4pueiUHak+jC9PArGSrWxB9FTVFOrawTz287aKkry8DBnvZ2irpHGVtpPBaLVEk4H8Ey0ZN4+RMsBSYfaNwboIFnAQkvs3YXAIaUw1VDTVtUyp/ndq1Q9L1LF5hFQu1bDt+J+DLBnw4CO3rwPzqaCNfBBFSfBCaskvaRnpNfWtvxBWI/zLttYQgADazSJWNBXovOGLCaf6hzCUtiXMmAz7qYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIW/NyfIvpBs7a8Bl+D8DIfKqkRbCfwOWXs3OFg7W7U=;
 b=fvmE0/sm5ZLrK8syM0N4YmPOEcKi+Y1ZwZf96eiGVj1NPhwJPUbZjyKmFvFzEcb14Ii8VG20mqi7zXv2LgclrEWUOdJ2ClaBzs4EDfTf7lTZI8xXaYiCfcRW2cn0JTlfaqzhzPDeHMg0SXvQQVSKA5a0fTDXx9IOvUBxb8GGuOhXncSFQbnC7OHQL1HlGvXH1ppJEdmhLpxW33mPff06OOgBQVHdKV7K180TPEQXWWs3zt96LczQCek220E3pzltad9XJxleyMwNUp2JJFzvOdnJm5jYT67P6VgkobxquY/+Qci/KU6RHLCfzGrjntqeSesuR9uGCWwCA93wzrgpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIW/NyfIvpBs7a8Bl+D8DIfKqkRbCfwOWXs3OFg7W7U=;
 b=dl2BcQDrGWUifRcVqAUTvHOZIWmxjK1BIG7HCCiWavt/oAI2Y9RHt6+Zk9NT95Sd2r5vuVRqd6CUt3j52nQ5GEbF6yKO0Yjgqng19OMBN3oL+SAHmL/HHT9aDH3h7CtT5bJiN9RhXlkV+/kRUkXmG53JvsgX8X9adlguA8m12i4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 13:29:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:29:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix file permissions on some files
Thread-Topic: [PATCH] drm/amdgpu: fix file permissions on some files
Thread-Index: AQHYlfLSjy79VI2N+UO/n8i6ermDT616useQ
Date: Tue, 12 Jul 2022 13:29:24 +0000
Message-ID: <DM5PR12MB2469DB8B1EDD5D668FF4D243F1869@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220712132455.2197338-1-alexander.deucher@amd.com>
In-Reply-To: <20220712132455.2197338-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc9ec074-5e8f-47fb-92f7-08da640a8943
x-ms-traffictypediagnostic: PH0PR12MB5630:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAZQY2ons+Szt82M1glizU3TR6CmmNCHBEntpxx0CBZmQJ/2eQsAv6u106Bc7Fsfh2ZE+3m1cxhGleEDVgdbq7k/MGtVy8hP6EplIIi7vX1HLZjlVHVH7qTUEcbBSsn/KJ/mdQLBGrbaz1zOYeWvFLp1WeCORE/i+BL/9Lxi3KfPS72Q0ZxmZ7F5TwdhYABHWl9EX9aAnubPxBRuJzDkNHQKCPbRBnZ3OuHBPzJ8urPFVNtoqGX6UnaLJTRyJLsujcd6Og8FmVR9/XoeQU7DJG7X179I6eS/qNIkwstA9rvMN9P1o0dYuuzyWozybGgQrFQ6PzuyRZ7/r3lDFptG7vjgUusZ0aL+eiCSfhKows6wcpm3mlemxL8GwIoz6R8gYXBDQgHJCyMehjaqx86nYYxQIptM5QapaqTbm7xtmT2L5sBypnn426Cg3b1ho47VboVROnZjP1MIYqsJPJQKcQz/CwT6fSrDOUidp0tdzwskQ4f5KWHkfN9gj4VkDgoU9Nu1yX+V7Jd1yuiuzMP/phdFLM4SUteaWI74bBBOg9/qHeZTrnzVVdFoJvVeafhH2JyZZGhkqerqfpfhfCjQ8EDgLvQ7ScZGlnaRxZcnzfe7MwAbdVnC1o5BoG/UtZSLJt/CZfeaHhpnq/bZ4PQ1BJDpine9puLFgM6USfLCMay9IaZAapMb9wcYY8ZVBiB5B0Mi21yAo+yDHjsgzIv9Gm8c8lSP4UHoLPwtC8CfmlTzIHTzu1hw5dvNqYfi76h6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(45080400002)(316002)(8676002)(66946007)(55016003)(76116006)(66476007)(2906002)(64756008)(478600001)(122000001)(41300700001)(71200400001)(66446008)(4326008)(6506007)(7696005)(53546011)(9686003)(110136005)(26005)(66556008)(966005)(186003)(8936002)(83380400001)(5660300002)(38100700002)(86362001)(33656002)(52536014)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zHima8akKfkV7QeLhZazetu0vCASKbC5S0t8P6ceyY7h9vTJmuRiOk040vdf?=
 =?us-ascii?Q?QAIvUgt77jP8f3n3/ITeQQrGIYMK2816ULlDkbm0Wz/9zVGlVCJRLaxZUpvP?=
 =?us-ascii?Q?f3G3bvU6RXAMa5WGoBxJd+hUYmy6MyL/xlf2YK/UtaDl71weAbXq9G5GNIWJ?=
 =?us-ascii?Q?cMbuTo1c/wPiIJ5GZ4dbCp1dNkmxcv+/f6jR8JdHXGavVCUI4be00gqWOK5+?=
 =?us-ascii?Q?8QTcDHJzTaoHWHHYPLytLSbLv8tCdyehm4LUYR7jySo1W7Hq/mu4F8uaNaGL?=
 =?us-ascii?Q?5pOVRVjb4PazMF1quF48uTUD8Rm2+ND1aYZ+SwfP537iRoAXnD+TK5pFWnRE?=
 =?us-ascii?Q?MXBMv6lquSixoXjAZ4ArUvUzRgLCc6CRHEp5U9YFuH0DXcMDSqfIfgE04wBj?=
 =?us-ascii?Q?E4lwiA/PESha+5KotcYKdaY36pNTslvJj/stMBgBeS4ZFR5P0guKqcPy9WVv?=
 =?us-ascii?Q?FJqnU3qebxJwKhuCkbvx2MeVqPUEZYpUs8yCqzlbjuiZKa4hFRpqxZVQtVOz?=
 =?us-ascii?Q?y2pyY/BXtwER+9OhMz3espwdnWeXcx7VNAtGcHdSu5rF7etosZHN22zucTr9?=
 =?us-ascii?Q?jgsm0enuMMcwQYZDtA70yrHOSLFUi6XTKQy2KmGzKJ6QtUNS0PGwScu7Ove3?=
 =?us-ascii?Q?+YNgj3vpmVN6yAKjnK+DzjS1dSnmeAhR76mCBX66IFhPokfz7ZPQ4byk6M6y?=
 =?us-ascii?Q?6Jgn/uqBMzbJo4Stb3PL6zwKBIapCm6FNAuAGvQt86gsLQyi4T5x3cgHJ8pW?=
 =?us-ascii?Q?QhuDZ7r7JiEgQ3FcTyMaT4/n3bEJFV95ocdV3EIcxhlpMBL7un6vEtAtX45Y?=
 =?us-ascii?Q?W0eLnuthHd0vJ78g/WykB1PRF8r9cGnM//FwpBjgxatzGzpHcQjRCEZXBo8n?=
 =?us-ascii?Q?7pUCBrCEEhBNNCUA/XFRHL7yLph4lY3wJ2ExSOnqDSojGSTUrruvHcwJ72Sk?=
 =?us-ascii?Q?4ap5N6GMadv3n/Jvg8ZT2C4ipPZrHeRgZ0D3MuG0/mxONi74oB9jTA5BlYPd?=
 =?us-ascii?Q?0XrAIG8IfLrYZd0Yv7bqhhdKpHKHuq13KjREL/Qc8OqAKdVCyhyzptT9gXE5?=
 =?us-ascii?Q?lNSTJB9ic1VGU1niO1lHurF1D8Bh23sB6Km35ntFX5UW6JfP6hPODxyTxW9X?=
 =?us-ascii?Q?GjET6Yl5g5MmpZ3qLUC0O6xocCH4aW66pogVvdq4iHQ3WppimoLT74xDHLdU?=
 =?us-ascii?Q?yT5nnKuIJCmqx+RC9QupI+xT11WzaHxwsngKWrb9gGnXq42CvRIbAqgjkwON?=
 =?us-ascii?Q?/3VTlIaKX/0EfAytiO+mebT7YtNuCPhDKY5/1LpQrdAhWU8MxHXq8rdW21VU?=
 =?us-ascii?Q?GsyLfknjOiGBkodk58Me7nbuTcPyKWP0CcludW0x/desK0Rj12LTdwnBEGgp?=
 =?us-ascii?Q?9dMNkKh/dBl9IkZjVnwus18jBUfq0yiMJlqxJdMN2IKQ7j/6mJyWE2pSslEl?=
 =?us-ascii?Q?Vx36wsw14FZ9rBpXGNWQj4p/8y2LDD+eFw/AQFbbsUzUfjUe2cNHIQdLe6jA?=
 =?us-ascii?Q?WDOJn1+nVn3HmvfFNYYJpi71wy8And8t+BbTuOquL90zgtbgAANFt+GV8p94?=
 =?us-ascii?Q?h9webP2VBnOxQDXfaFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9ec074-5e8f-47fb-92f7-08da640a8943
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 13:29:24.1547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iASj0PFB8mFLzInxtkIxJ8W/IfiKld0ZNy6ZX40oUTfP88Al9pc1bJXzbmOF5dz9wvXExOxVxRbERPviX+dFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 12, 2022 9:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix file permissions on some files

Drop execute.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2085&amp;data=3D05%7C01%7Cg=
uchun.chen%40amd.com%7Cbed3731629ce465be5fd08da6409f3ae%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637932291153290505%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DuafTkEmf4xKtzs9lMnY4e3ygXK5SutnPmtsegRQ17aw%3D&amp;reserved=
=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h    | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h  | 0  driver=
s/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h | 0
 6 files changed, 0 insertions(+), 0 deletions(-)  mode change 100755 =3D> =
100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/clk/cl=
k_11_0_1_sh_mask.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dc=
n_2_0_3_offset.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dc=
n_2_0_3_sh_mask.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/d=
pcs_2_0_3_offset.h
 mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/d=
pcs_2_0_3_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h=
 b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h
old mode 100755
new mode 100644
--
2.35.3

