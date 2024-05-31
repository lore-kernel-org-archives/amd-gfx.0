Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7E0C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 07:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C904B10F3DF;
	Fri, 31 May 2024 07:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXVtt+RZ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BBC10F10F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 07:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OECfl05pVGlQQUG4frkgx6ZpeKUfPBrCW7z+HRE4z1uILmz4VDsJmYeJFppHK7qfuWs9CDMdi+pE/4Uf0VwzlLiwqyx67tnjwlO8yihskCFbkUs7mrRhJJrdybpS8VGd58WxZuDJ1KQZsQ6B5OuCTdupJcBhtv+0HHkSAd95gyMthekWX/V3VYBaO5wNE+phY+YZewPO0KaLPvrZr8uhhgC1EfMZeo86xSYKabDnyP2D4KNvA33OaXFHXF61jwZOJlSL4VCbs/DFa8+n+KSE88gCzJQRpbvB4T7ZtoII9VOyNmYokQOG/mCYb0J6lDklcd43ko0zLrxRJ8hl6wVeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH8kcB0qMqlxx2vP9+mTUpbI17kRI3aRg65HPVc86qE=;
 b=gr3ie7oSsaJ1OB5AZRPji6NumiZ9j1a5HuMNFIIHlbdu1pPzT6hvbfhl6+CBOJYc2QfiNOfasddcHPRN3X+DidoOUK47CBBxiPgXfVdfaxM/8EmaiYNiXuzWhUC51IkKh3N6GgrGn/8P6Z3qtzuj0hdrAIQyfX9xVIadIo3cgW9/Tl8IfdzGTcdcQPaMyQf0GVwApm+2ymhTCYTAbfrSasknlDUkdHlvA0ThfA0Dmuhu1f2frSGHltwm7jITzuioS7AVP9ZZgXL6SXueVaWghFNXx21ZjgPYk9kGBtw/PPk95NpjxyB2fWhfPud73knpnG3Qj18zch7oTfIcD0fewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH8kcB0qMqlxx2vP9+mTUpbI17kRI3aRg65HPVc86qE=;
 b=gXVtt+RZGQtS2hRokwkOxTwTdZzATNVlmZtfyLG6oKmO91S/ubZBflJ5/ClnwG2btSOMVBJVr9bh+HLnKiYf7qqA+8rM0NPayBxlV83KYRE7U1YVFSV8T2onrE+8Ncgyrj8cXTCH464xmh/coWIOq0L6wpJIQ/jFbj7KaD7CkBA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 07:43:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7611.031; Fri, 31 May 2024
 07:43:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Topic: [PATCH] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Index: AQHasy0lEunra8BBck6Qa18ZrJDKw7Gw9VZQ
Date: Fri, 31 May 2024 07:43:25 +0000
Message-ID: <PH7PR12MB599758A15F50AE3276276CCA82FC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240531073531.20364-1-bob.zhou@amd.com>
In-Reply-To: <20240531073531.20364-1-bob.zhou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b77b6254-1b5e-481b-a5a9-696dae643fe0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T07:40:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW3PR12MB4394:EE_
x-ms-office365-filtering-correlation-id: 889dfa7e-cd77-44ea-84eb-08dc81455aa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ih5yd33GR+WlgywEK/z3gsfBaAVkYWXqEoZScM2j2RkIKDZryEgYmOf7Romi?=
 =?us-ascii?Q?8yTSnEn/5rrZKTZpLWUPoteyPdxvzvoyxGYO6Ga5KuHwK7+GEn9JhMKocsCf?=
 =?us-ascii?Q?NoGoe8SfCvhoIvAUB6xz79CqAGlxcaw5WUAhqyC1bcPaIVinzdlVDV9dIOmD?=
 =?us-ascii?Q?jT9ETWXLbm2R/AIExJef31Y/ec4ljLpKePkY+1R0u9iaJSOBAAX/eDGgqnEh?=
 =?us-ascii?Q?lJLAPPuTCjDB0JWhp/TS7ay+kzuF+23n14zEela+jvS+T3Wl0GB17V7LXsDv?=
 =?us-ascii?Q?yMH0EmazDONKxUiPEdL9vEr47umquyMh8/x+DwYvrHNYJJXvOjMuYLHbDYcw?=
 =?us-ascii?Q?6vRaH52XyTzdagLVzu/buhMCOt2fMEk7Wi1XxHzTeQDi6PsVAFB2hLkMUYup?=
 =?us-ascii?Q?epcjM1DWjl+yh/dlYkIzRuvvjwAWLjFoqjE92IFuRG7vLA15Xk7EUzpiXMco?=
 =?us-ascii?Q?xhRQIj+Y85nrkFCY7jzTGlX4Wl/N9eUItRzhhtKYQTRcMUVnr13R7clCi+aw?=
 =?us-ascii?Q?mZmpdtAdbI0Oy5kw0mSstHvpzqMfteOkXddKKqHOq+O/WRAuLDK9dumcHlU1?=
 =?us-ascii?Q?XcsIvXH8KplkIYjR/WV3p5oYFQhBmH5412W4jG2gT8ppd5Q1+wH1Ef9LSAi4?=
 =?us-ascii?Q?KomLy4KxyRTYvkZ3FpmaqmiaW0XLvC7ll0r/fynozGo1bCjD4djve3qMtiK8?=
 =?us-ascii?Q?dSkbdnb3nMc+9k242cSTfgiZhcEM9wJDKswD90CHkW9YuuPBvdy4OzTm+b76?=
 =?us-ascii?Q?1tSv7xfmwnceK5WC//JOmpe4ccX8pQhG38etANthNKtPRyz7zXrY+YUzVmCu?=
 =?us-ascii?Q?d2BjKhx4CAco5XL/h/6Ebjg1nBIiwLQ0a1Gvztj8q5bnQitMiBzFiSxqtfwE?=
 =?us-ascii?Q?TT0TCeYMwgJPtdlZ6JUOd/ZPJTIdfAxhruGzSoKULU2eq0PbSpw2hu/TrfP1?=
 =?us-ascii?Q?opyMGiIzgCvwS7v4KTKy85GuaeJ8NOyGSXb8KbBfmX1ZAVCI3P5+2goO2TCv?=
 =?us-ascii?Q?DJHTB+/eK1ZSTRXsAMO1czA36LyqCPcMzZsZtMB9gfHLaFcil3uEPZe0MICZ?=
 =?us-ascii?Q?DxKUh6UOsJitj5Gb7BT9teK/I3Ha1KKcl4iFXNIHIh8Us559HmLuKKh9Hpvf?=
 =?us-ascii?Q?heXhVQlVfIpY0/kuSCJ5HGfram37LrMqID8EvMyBz0QnfzeRsprpZxvep+Zl?=
 =?us-ascii?Q?Lq3Guc1sqPrEuBdjc6YwGtQNEsFtWR+12Nn5kcTDUSAwLiB/s+uTIIXHYv7R?=
 =?us-ascii?Q?9yMgsGttgINXSnDGfpMNkYn0q9NxrejLmLrfI54E5vDCmgKdB0lVdGNSHe/M?=
 =?us-ascii?Q?aXcXKl8WGOOu2B1CU4YrtmtYD98+erQlXUMnCcb3/gpqag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a07CVT1vSFIWoX9liNx2tfYXGj04vbxzZM2G74bthYCBkRNw2JX2dBRHQIo6?=
 =?us-ascii?Q?AHQaGBkVJlerSiC6fz/eY9BwiEJcFsUfkS7DZQKQ42UfMpCvn7jay6Fa2Ll7?=
 =?us-ascii?Q?m1jHPl2vw63N7ASM4FeDDZIiHbq1TAHQeLdI74alSUoB4dJsxhv7a6A3XWPA?=
 =?us-ascii?Q?BubPMYgGmM5dMSKWJPvu7WqSOACuNJ2/eyjYpCy2j8zwxxOzG40/Oik+GU/6?=
 =?us-ascii?Q?fCEbCizXeLWFRBfpHhhVKTUkElTC2uSei2ULKyym1GChxPLvgxviXxAwfAoG?=
 =?us-ascii?Q?A/qbp0V6M9NOSHItRXTIgrVgPAXKR7YtAqvpGnwXypj7O9/798VL3mygwfIz?=
 =?us-ascii?Q?Y6osTVgWyrko0xfGlhOSZ5mXK14lFoKw8X04JdDB/PZ5rt12CLFLIA74QjBh?=
 =?us-ascii?Q?/xmAV2D22FYA9pM/gk1P0g1nEghCscDwJMkOpqobNMR9Bk7f8rez+Ux4Bbf6?=
 =?us-ascii?Q?tFHOF7Q+jpTHsskThOGO3VT3Y6Ibf5X/Dz8Jdgxu6rA+s7cwlEd2TARLPz8U?=
 =?us-ascii?Q?dzigzt5uxj0QUmAg7/DwQh+kCP8DCy6ZuqPut3uzhDCWVNXOMH4nDsAaIX3b?=
 =?us-ascii?Q?B564x71TpFKO2eRUqv7jPV0aJB52KaEVeHk6Z17zXKZ8OFlafUrcKxGv+YJ8?=
 =?us-ascii?Q?c85kENFw5Bmb7iHcyyY/tIn/PkENQXkgzoPwsPOTcRzvz3P764b0Ngjnt8Q+?=
 =?us-ascii?Q?JmxKYRA+pbqYtk4FaEjPU2aMUI2/ec+pS5f3nIo0FngaZ5ToSCisGW/iKQlh?=
 =?us-ascii?Q?G3b7PXlhW1Zsz5NC8DdNqQn6EW7KhGIKPKTo5q2dkYrl/lTnUeLV3rKESek4?=
 =?us-ascii?Q?hYIdy3VVsce8phJeyk+io59yAjffr31qmMAWuwXbjc9Y0sIX1U3sHBS2WTd/?=
 =?us-ascii?Q?vN5nV+XzbKJ29GKleeg7rbYr45cR6m/EwAmVgasR7nDLW8DNENaPABVfXp8s?=
 =?us-ascii?Q?vnY/SObDeIZvj0MSxLEfG0UQb+yeJbFTgiN15T5mDzCeWAS/t1TpcE3AG0ag?=
 =?us-ascii?Q?8UKpDoM9XMoZM2p4X5dhFC8YkRx5DCb3KpYgT6FqmMMO6YjHO1T9arYnO9S0?=
 =?us-ascii?Q?Lx/pifcev+hjEqTdc+LBC86qhXBMrh6A36sJp48OX8rRhzyzUgL4IY7RUG23?=
 =?us-ascii?Q?Ur0ULV2eXVUpKQP5+HMDmxU8yjCHERp7StPKaxoLyPETx9kAMjScQsWas9Rv?=
 =?us-ascii?Q?ZtTICrgWJViPMRMrCFrK90hsF1vx2f1ksroVNHo8r2gr4EVmzEdwnKkylRJL?=
 =?us-ascii?Q?dISX5cC6DbJ+9yQv+qY4X+e3Bc75QTCqc4skG/u2lUbbrSLJ3vUS7okwpJcK?=
 =?us-ascii?Q?hRNncq2zH/+0+N+kWrBTTd1bFmbjIt9zqr5agPY/lnvTkUoAQINxj5eHN1h3?=
 =?us-ascii?Q?XORgKnk9tvd8WzFUhohtujQzw16lUunN839VJsIV+KQh1UpAnDS4Z1oTrC8O?=
 =?us-ascii?Q?b28RfB2DdTa6Mq9Dkh6Wq73Ru5WmalQQGSW4TaywdDMuHmX0k464xMRFz56o?=
 =?us-ascii?Q?fqpUGwMe+W+w3K/5/v9NDyne5lNqijHbYR53UTLEmMG7aDcJGhXr0EQkqykd?=
 =?us-ascii?Q?2d74TelVB13AsCUYLP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889dfa7e-cd77-44ea-84eb-08dc81455aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 07:43:25.3028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmwfljYGahv3eei21Rvxc4KZam096rI/58LXPvKlm9ixpE5RuJYDYlpU+/yN54YP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bob Zhou
Sent: Friday, May 31, 2024 3:36 PM
To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang, J=
esse(Jie) <Jesse.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH] drm/amd/pm: add missing error handling in function smu_v13=
_0_6_allocate_dpm_context

Check return value to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..419e46cfa065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -451,6 +451,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_=
context *smu)

        smu_dpm->dpm_policies =3D
                kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+       if (!smu_dpm->dpm_policies)
+               return -ENOMEM;

[Kevin]:

the 'smu_dpm->dpm_context' needs to be released together to avoid memory le=
ak.

Best Regards,
Kevin
+
        if (!(smu->adev->flags & AMD_IS_APU)) {
                policy =3D &(smu_dpm->dpm_policies->policies[0]);

--
2.34.1

