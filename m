Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30409C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972FD11A222;
	Thu, 25 Apr 2024 07:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrzqJ8h1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D28E11A222
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li9gzE+6YqGhqaKBf6bPjESw05DV7o3gUc0961AZcbDsY7DAQiQAICcccCl1yT45bEMvcZxPdIea0zu0/V8VuzjRYqKw8qyKjGk3QaMpiLNXeljwj+nZ5Z1w0VCQXBv0MBdGnu33iX8ATgD/M2yy3hx0vFsFb52Y5ok3sdY8/mFJg862JxaQmPMQHrMUPLXoNike5X/j7c2V5vgFvK7uIUaj4Vaqa+oH8Hw7ujWh6brBpA0exreE639YDCRcaneHkMGIbofidWMGJjcAfNEJ92g+G65PyDbLbTja1Yu5I+boKSlNOkTeGyY77zfPD9+3SqSi+InzsXOGIXUYupjrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGGLJbRTDriGeR4irNrAS4Y9ZOHW7JssSSjN99MHQCU=;
 b=eENSZawhf6K5eKj/rSEIkvj8ISAFaRDNX8ZgRG4jjWYsoWStqO9YhYLHZRvgT1X1lXKw3gHxpw+HjKxGKivqzVkACn8AajAu8Htvqsux6HZkQaAuMgU9yWiKaApggykbMwrzBfnFeti5hxO/A6RvSTD6WgA6ltMmrecIcQugTma5WFeZMFHCjwL4vA3HtPrHMg+R4F19pO07zwPR+r/aeoUrUONJP0fp88GHal/cx//e6pQRey5a3bWiaOVkixjU3hFG89dtUJET0K0sg1fIhJGmCEVomSc6b5HvbTY7zuoN7vw7kublPgLdBsFoPdFzPJnTof5gDj3hyPSmCGWPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGGLJbRTDriGeR4irNrAS4Y9ZOHW7JssSSjN99MHQCU=;
 b=XrzqJ8h196GGhTvUdoNM7YDQLOfaD7tWmo+yMMB2THMk1uyYnED8d9n/UwEdDCndk0mWHhuKpkxfAqVcCrQURYwu9YVJCU6YiM0Xlch1VsZNx4x7nj/u44+nuqS5R7HXIFVaLs30GbCeoyMLnqxlF4ZTNWdw6h9GEuf2T8io9mE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:26:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 07:26:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
Thread-Index: AQHalt9X/A2+q+Bx+Ei0Yepl7M8grbF4lUFQ
Date: Thu, 25 Apr 2024 07:26:10 +0000
Message-ID: <BN9PR12MB5257D3F4A81B6235E7382514FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240425070750.4058395-1-Stanley.Yang@amd.com>
In-Reply-To: <20240425070750.4058395-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ad9cd06-66cc-4512-87f4-a5766a7506b8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T07:23:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8111:EE_
x-ms-office365-filtering-correlation-id: b721f6a4-6861-43d7-8bbc-08dc64f8fab6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?IdOzwVK3ay7RoZBp0OQTXzUGxafrAFLOZ56DU9+SISKBFgRWclrFB/I4a4eD?=
 =?us-ascii?Q?OByPAASmLSli0XU+Hnz7T/VEgBamwc4w7IkzzIpl26MEP9Ma3hg9ewTR70rv?=
 =?us-ascii?Q?7YclxEmOuQNvdPZmdaBnMWsu3WsQ5SG0kVwmCww5KCkfMmnKxew5OO8c5dWv?=
 =?us-ascii?Q?72cKvhDOK6GzpZdXZa9xqrJsKhlzoEoMb8rOZ9BJjCvhTxcmRaAudTpSQ0Vt?=
 =?us-ascii?Q?7gYFfPMzmCCIaBRq79KNr3wQEgTdOfgSCZu5dMG3TH2LIPBDlTgdr+qmUeuD?=
 =?us-ascii?Q?1lOzH1dHbpifezSuOnbpi4S5VVXbObNiK3d06sXwtDepylNgzwLtq8mX8W96?=
 =?us-ascii?Q?FI0Gs/o8iAFrWwiVUOij5YH2/jZrfsxecpeHk4MBcXI+L26bTE4YwrN+ZMzr?=
 =?us-ascii?Q?G3/8zeyHEyaqfOyo9StNZWE4kJxgoD++iL7xFmEW+jDgEn6edfNGL3EM2mRD?=
 =?us-ascii?Q?LgHR7NwVTkggnb5zKkSZ2AaVzQZjvLk5vB2JreQcZe2Za8VwzQ1Hr9pk/CE8?=
 =?us-ascii?Q?nBvfZylucsIqLVDuXmPEHENPZJkET1AwBCzoGY5Y3GHOyiVxgGklgD5VLmfZ?=
 =?us-ascii?Q?h1q42rzIXbUeN8jN1uIK34zcQNb7yeE2JT2wint5R9OUJQ6mWmAbMq3LzkMK?=
 =?us-ascii?Q?02TW0Vm+5X6n1kGtBX1XjNaEVv2lBQ4vnWqpDL9d2kRNs5bddTS7RLVvTnmk?=
 =?us-ascii?Q?70LZ8wOHX8JtOMyqwFbkxrdGyCktReSu0Ov2gOq65bOKBnfCIQcDrV8YURyt?=
 =?us-ascii?Q?W4vbijeT0UL945/bZZeNIJubOOg/CxPnJPMUX1CGMT5af/5WVD5Xazt0k4CV?=
 =?us-ascii?Q?UX7LmKeTehhIdL/9sbv3F3gkkRTpzTJQ1N4InZyA8tWm2ais1OAUC0HfAJg6?=
 =?us-ascii?Q?5hCms1AFoRFTc7sLM4V2h2gfKVKYxF6NsBpOq7ZcXZeXo8jOCrBHR4foVyk4?=
 =?us-ascii?Q?UfkT44a+6GI3Dz2rqbARe0hwzk27e9NRsr6L7DMDTvn3yF69g/U5S9l6ogjd?=
 =?us-ascii?Q?j+WHdDik1+lyTNyEdD2Rg0lvN5zq1Nq86T+URbJ0sJoN56jrwU0CXuk1YnQe?=
 =?us-ascii?Q?GeyQ7bPFsB3rlo5BjXeN1H9kKd7LUBMrqEJ3E7qIba62WCTsIRJScdrN6rDr?=
 =?us-ascii?Q?XN7uZ+n8RCYyF0DhhHlWOzrT5i8tIIjcniPhO1h5ZFDV13XR4UwhddLPhHrM?=
 =?us-ascii?Q?JqilZW2j9l8tLc8eDn5kVk20nVEkQx3w11Yryzn2ulWLpSH+HC4KrBr/kyZg?=
 =?us-ascii?Q?tgEhUPdZ6zkOW0DLkUElyTHwuU84zpuXnp37P4mB7Svcw2GvfXBAyB5YWVkn?=
 =?us-ascii?Q?2e7cy9s/bkeIZZYmG7TRwqPpf98oWttZyWYxo09Kt3Bn9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HpReeDqXzLLycxAJZomnHZ2HVuIcFQYm2swNixvpLKpM09DjJd5NBY38UTd?=
 =?us-ascii?Q?7jyMxteXLysUAD9M2kviq5taYqmAHmVg2po0/VZN3xPciAIcwRgjvlTwW2CN?=
 =?us-ascii?Q?efvqFu4RO3NSwFWMRUQQi5r8d7JiHsO2EhxuFm68Y+YW7AixWeL4tGOBmmYY?=
 =?us-ascii?Q?CEuGwEUPmBEz6/NL4JWLomH5GylpBJDG7f8arkyTW/krJkP2RWWFDVlZzlkD?=
 =?us-ascii?Q?fkszUKHCXWecsW697qVZcGBB83j8VGxSkH5cI2Jw2+YKiks/flnsNEUKAYzO?=
 =?us-ascii?Q?1XxDMZmcGb+zMaPlVYe70ZGfribkO4dkMKcYpAsajPFHeI+wZrNIY/AKbxut?=
 =?us-ascii?Q?TDKM6GEm4JcXOwGqMcE1ddiuRassimCO7Lju2IDmn9Hd93haxGviydBttzfM?=
 =?us-ascii?Q?ttD6HeGIPfstslPI+6oroGcpeKqnUWeJjh62kdrNV8fmzOh/Srq1Jc8Dl4OB?=
 =?us-ascii?Q?+8aaw69j/me28SrUyoSkAvtYcAVpC/nX67cpjrvFP97aILdIIV74uydUfiyQ?=
 =?us-ascii?Q?ACt2sSUdIWv1VWmD90Hrsb+AkxngbmM9GhBEaolYWztK5gFjYcqWk3D4PsAE?=
 =?us-ascii?Q?EYsCGA2OMucxYEMLimdZemkIoH3UwgeOr6KiTbWEFIVdlV/n6hHFzHN1PBds?=
 =?us-ascii?Q?MGEFsua8Yv2tpLL6UO2j0A0sFvm8xvLTw2DHDTo38Ov2B4OPE4tUSJysZUT6?=
 =?us-ascii?Q?OKZOU1pIGIAMOmFz/ZVMykS2waIscG4Nslt1MdW98P6FNYC/P35lEpucb14O?=
 =?us-ascii?Q?WL+cFLHSeDXT2O7Sk9JNILXo/hFJ0U1uuVcw4HdpbpNxtRAlT4mlsUk2iq6O?=
 =?us-ascii?Q?msrsp4DEq79VphAOnKhrXxBv+t9eyJt1I9SVzOi2/x+gdy7IsTzN9/7RlJ5W?=
 =?us-ascii?Q?ad7PDDjS/DyVwxoy7A/qPvm/n2lCEj0YzBvLJDJWHXvETK1wY0j6CY9TDmjl?=
 =?us-ascii?Q?EJ3BzIPGq22aFo7iYWk5+hoZOLa/3xoFeDI0i/Q825KwZ0Uvm5Qf4KCkJDje?=
 =?us-ascii?Q?+ZA+r+F3Sph3z+zaqfDOeSlx/eYNQY+eSid/fTzCXo4JyP8aCVNMa0cCd/rL?=
 =?us-ascii?Q?AWjvATThkuNx1rlnF6hGkzb1IYhfjvgZXsZirM2hf0MDnPRPtk+xsuKoaz4C?=
 =?us-ascii?Q?w0C4lmOAhsyAV/ZO9sCbKIDPMbyEITug84ICYkK8j6WjFgjZrLsEHRAih70g?=
 =?us-ascii?Q?GeFIsi6CuN7kq0PKytumg1MRTHo7is8zZfn5ljHRGwcjNmSriJ1/tuqes4D0?=
 =?us-ascii?Q?P5IzvQ8oWUKZcz7iE/kIWCbn6/tS9HK1ZdCMwdy5WClLexJCgcWEvXrR40JU?=
 =?us-ascii?Q?iM2tK3VIJ/9VieKUF7TUmHOJn0zAOPgLdL9BdYWulw3KsPtIkj4oHgCz3M+J?=
 =?us-ascii?Q?2lKfU9+Mp6uGbXLJGlPREadwIQY31AfD5Davr6S1NjphKejtztXykDIRK++8?=
 =?us-ascii?Q?aAfmTpejY901RI0X5BPKFi7oJEZExvP0lze+hMYO50U4j84cmL/Vo+hfCxKg?=
 =?us-ascii?Q?ni4W6A06LQ1shbrwC6otLwLJYXPw63Qs4QjnuS+2Pi4/Oti6KAAlz/6HGzp4?=
 =?us-ascii?Q?k4v3t2xvj5lMkhFtzW2sQiw1U3UhYuxsCgrIqgj/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b721f6a4-6861-43d7-8bbc-08dc64f8fab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 07:26:10.0329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At0ZVmzAsCB4e5FKY9wnsCFheLhavXXeLjrF/gYHk4jGl7zOGHFXFoMcYt6sn8PIogcei8MzGML68NMo20avZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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

Hmm... we do expect PSP report the XGMI/WAFL Caps. This is different from l=
egacy RAS CAP check through atomfirmware. But if you found the XGMI/WAFL bi=
ts are not set properly in the new PSP interface, let's reach out to PSP fi=
rmware team for a fix.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, April 25, 2024 15:08
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit

The way to get ras capability has changed for some asics, both of them need=
 check XGMI physical nodes number to set XGMI WAFL ras enable bit.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b2a883d3e19d..ea77e00cc002 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2918,13 +2918,6 @@ static void amdgpu_ras_query_ras_capablity_from_vbio=
s(struct amdgpu_device *adev
                else
                        adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK__=
VCN |
                                                  1 << AMDGPU_RAS_BLOCK__JP=
EG);
-
-               /*
-                * XGMI RAS is not supported if xgmi num physical nodes
-                * is zero
-                */
-               if (!adev->gmc.xgmi.num_physical_nodes)
-                       adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK__=
XGMI_WAFL);
        } else {
                dev_info(adev->dev, "SRAM ECC is not presented.\n");
        }
@@ -3002,6 +2995,13 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
        amdgpu_ras_query_poison_mode(adev);

 init_ras_enabled_flag:
+       /*
+        * XGMI RAS is not supported if xgmi num physical nodes
+        * is zero
+        */
+       if (!adev->gmc.xgmi.num_physical_nodes)
+               adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAF=
L);
+
        /* hw_supported needs to be aligned with RAS block mask. */
        adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;

--
2.25.1

