Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F7606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hywxgR9H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AD910E0A5;
	Mon, 16 Nov 2026 03:33:30 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F05310E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 03:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIGlJyt1O2/hcLSRU9bVQJSAC3xg8y1ge/8fOs6VFEC9aELh0UYhDkzpek1fisLIT96uy2Q12h6cXfdBcLduHDPPm+MQxukQR9EwAvZLM5c3vl6uhEjS/wqsyKWOoYt/PXQ+GWOrn8DDDaadHnAFJ5G4AMhWx2TE8vUQp712sOJcd7uo10kZt+rS0B11250DRB0uPqMv8xVgIzl3yrj3vDwOORultPu77wwynPvSEEGWqOXD84oj8wQk6sZtxVh9dJ1SXhdOVN8Ift5TAWpaj/25fMhSxx3oPbGppxyRrQzdHxScQn0XNkutUMQKbb3zn1n8Evc3So/z8wil4pfn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alw1gDQQ9py9yckVab0ZPq4CHVPRgbj4D3aNMt3kT8k=;
 b=HmD3NLUqQnTtagxH7xqhUPounKMM8bJtd3+B3hsSSWPo70pJ4PEpVNRABEvibehE5eRsM4OKIqtkVziG5m0Vnc7xt2+0sQ7Nve/PD5d2ZdWcaSjSsRyd4RQs/yokmZrH//l0FGUiJl50raYgZ5nEHs4ILoxW6ljIRE1uQtQCsCO5rQqhQRfuqEiOSBFsgmntfRX9CQP0encVXddIMn/aI/0nu225lwjrZJeEHKXAGq2FBUUN9cv1KyYw1VBnHcSBxWFueDbi2dapRSSpTOcULsjS83WwwUqkmNI49KUTnRH6S7wAdzAaryblc9nyhSpGoVto+ZqqHwuccTxB5IrmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alw1gDQQ9py9yckVab0ZPq4CHVPRgbj4D3aNMt3kT8k=;
 b=hywxgR9H65tHR0SJAicSsjgX6BF6ftTDVz27cP0F6AuOBYfc5cVxMUjQB7qB0fUD1yZGlwPYU/d4/kW2P3CqhFv1nEAQ4MSs4UZDZPlknxrrWUabCT4ycdAHCMDV/gHOl370wjQIKz4M23yCVDK+fF2DK4vDQACIRAwHbfJlKvQ=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:32:18 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:32:17 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sun, Ce(Overlord)"
 <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Topic: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Index: AQHdcyPvfC/JcOOHIkWqsltfYaivWLcsJduAgAPn5rA=
Date: Mon, 16 Nov 2026 03:32:17 +0000
Message-ID: <BN9PR12MB5306239C483D208A1FCC8267FC7C2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20261113032813.352632-1-cesun102@amd.com>
 <DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2@DS5PPFFF21E27DC.namprd12.prod.outlook.com>
In-Reply-To: <DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2@DS5PPFFF21E27DC.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T13:47:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: 84fd50cd-0c69-49f5-9a0b-08df439236cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|4143699003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: layHIHfnipY9qvE7YOxqmonmP7HYGZXXT1PCYPgzD6kuqPabci7uBmgWFoHW7VHqM3V0Xd/5gkydezRQ7IPsoxfLXqrRMDjaywx/2Lze6s4pLftyBkyDPCfmMCnMcqWsXBW1MJKXWJgTax/pSTqVpt14/Tmtku0IAU6aG6B1aiqxe60NCSBeMmpY+G2gkxECIM9XDHAzTM4zgcwKcJkCx3P5XuRHD98aMKT1+yHZHFelzEwDH0Iz9Hr0kYeUxUElQZMSO/E0Uy3GcCl2B78JTqQIvrF0Cd8HBpPLHVlja3S0qlhHd1yLw+bfZFNbYi6XvNfKHNiT9hPlY3qFc8gDjggPwqyGA1Z9Npd2Rx6MBU9DsQHk93reEgnjJ7HjTaxRYDzpKJAfoFp93M6S1nhqBTuWvm0eWUiqvTvR9bgSpjNHu4auIXxEx3EY0eo9FL9MhwnezNzvRZA7deBUlrLsxUiqwEoeS03zc0eb55yaK8Ymb2qDDOjozN7oQxgK5o0nj/NQkzZfH2akx+DCyR/19tSbr3ZgeUMuUllHYNsjEXg6awjZ+2jjFuCVUaEhsY9WpVp8CBAp58Kzk0AgCoKzMojy0W6hGM6y8R9JfKYoLiP7ezjz1k3GM9EY8aoSBqFXW8Vt7kEJ3fnM+LivUuDhe0DFv1R6smKS9n6ve8yjrwNd3gmyUZTNfuLvdPerVd4f6ELFNrGNRd8P7DEsAmdDJMEaLrO93oyaIAiXBNSAkBY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFafpzkKvVJ0nP7x1OQ3GnwayaqcE3S1JN/H8xxbsoRLTERxL7TrRR3fdQxS?=
 =?us-ascii?Q?l3CeYvfIi6Y7CqheNqX7Eo4KV+EP6/m/3TURhNmeVofkad+VjfGiRyBiBK3D?=
 =?us-ascii?Q?wDfVHQn9mUhISQlswE6//d2w8p1BgjspLdzsStssAfd4Vy6kmp09GsgTbiZR?=
 =?us-ascii?Q?FlHYw2G32LcFbZ4rcweXUiYertDppkqC3z8DzjWYGMSHrS48oiOuQomez8dx?=
 =?us-ascii?Q?VCmVT8G9p/vL9io4HSXewkFYiXXhVjWoOtLvSWPakxppdtN5Hu6JZrvbzbal?=
 =?us-ascii?Q?WW/45Ax5sotUlFyMR5YN7nBjhVTvrae+HfD9KhUlo+Ky4g69OcylcztQY68O?=
 =?us-ascii?Q?YYGDKHLRswSaJnCjn33f6iAdsOHYqNFGmzCnX85yFXXMkp/LJgL3lkpY4Sq3?=
 =?us-ascii?Q?gXhAoquWNzhVGTiOcDe6EuCavG2xwNqzHRhOIaexHkg5MK0SOv4XTkjER+cB?=
 =?us-ascii?Q?zS9+h9bTjsvR/g35m0bwKpdLzqqn+rgrq5/rWD2YFRmY6sNsq77MvHio2iCV?=
 =?us-ascii?Q?c7AYV1lpLniiLFvnBwVdTGK0+MqlgBJwJvfvu4ftO1frrzAFbafvnDcqk0Bc?=
 =?us-ascii?Q?VLPs0wvyOEWDeNZ91w4yQEiaymOhPdcnj/oSnThoEh/ekjOu8cY5IEcJvBVf?=
 =?us-ascii?Q?0Rd2NuzFtunK+Gh4JcPnWpZpkhmV2XN8RCvOTai9hjIOu2dMsgOasK0NP7Su?=
 =?us-ascii?Q?7v9oOa1H9cnD6/AHiWunVWfkTOzcCvwDMbl7UY/UNjij2Xoi9BLMEut0ZrCL?=
 =?us-ascii?Q?XBqaxz+5AsQ6/1ZfQzo6QZQYM3wmROMs+sDSrw6bn5KXgpJJJTQ3xgAigfdM?=
 =?us-ascii?Q?nylNYHw+MPiUTwKqFjHzHKM5YWIUvpuSUDsBfxO0jJYNGJvCwPH76UEpJwfc?=
 =?us-ascii?Q?aAPDBwzQSNpU2GEaUeQOBHHW4gVcHOg4dVUp7aUXjWv/t5lj9lY+zac+nsn3?=
 =?us-ascii?Q?DZgvQA8lx695/g6LMl/nuUhxnupWo8rwvhrZj9quyLZ/8h/+zcI6hQIWgMVb?=
 =?us-ascii?Q?obuRMcZZKKGvyWFepbdWJ8cPDgv2MQiUc2Go9gXrpWV/b2UokLqofbSVWTsI?=
 =?us-ascii?Q?WVaEbiM0aA3krUBDdaKmbdlp4DCX9SciWZ0qn65nmvnInv8QRZ8+P2xxpebO?=
 =?us-ascii?Q?dajaV5beC6X+mcUhZe3Zp5Pf1demjMCNWzC5T8YOvp2gNNyFm5EXSO9YO0G/?=
 =?us-ascii?Q?RdPlB8XQhrQHnI/cFsDbDODP3nGFCSvR8RV3JuVChvrYE1s9vTkRHljaApO7?=
 =?us-ascii?Q?6PrH+zpxGyStF1Kq3jrXpzMDLb/+DQXlsMN394XA7hAhClKMM3W/4c24IcPV?=
 =?us-ascii?Q?3KrPbnr4oE5Trjb1/SaUrw2+JHCpnMLp83z0IuN4PGgWUlz2EvioNWZV3jLA?=
 =?us-ascii?Q?UL1DqNMlbgycvDT31GnsddOkdm0dLG+n3oh9pViudueqY6GQmus8d0vTmTnb?=
 =?us-ascii?Q?fRJ/nNCy1CQLMblsw4M6fkzJgnMDpBwFGJ+VoJLCFhj7Sh4th7m8Ebnh9x9z?=
 =?us-ascii?Q?w6qaUtvV56NDcfGFbRnrdS9L5KcKcmYH9qlocpxwlf8o9GvfItQefOxDnX/v?=
 =?us-ascii?Q?HkMoZ9iAkpc2Ok1QThbvG1Q44eF9+Xqi3Ps4idD61h73HJS81WgJbJd9v+dC?=
 =?us-ascii?Q?jiBqPr55ravn3T5SksWl6TVBHLDR6HcOUhgVU55fWlWBNM1adN7rLdX53/if?=
 =?us-ascii?Q?qL87feFap3EVxSUkgYXQFi2950oFBuCodGE9d1z2tywPG99Y?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5306239C483D208A1FCC8267FC7C2BN9PR12MB5306namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fd50cd-0c69-49f5-9a0b-08df439236cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 03:32:17.3561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcJWAFDja++WH3ieRwjHCEvCdsVAxU24vqKhHOg+mPdQbfBsaarTae7rRBVYszeJReo4Azjaz5rfgqptDUqYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_BN9PR12MB5306239C483D208A1FCC8267FC7C2BN9PR12MB5306namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


BM reads the RAS error count for each block via sysfs/debugfs nodes, which =
ultimately calls amdgpu_uniras_query_block_ecc. Therefore, adding an SR-IOV=
 check inside amdgpu_uniras_query_block_ecc() might not be appropriate.

Furthermore, amdgpu_persistent_edc_harvesting() is invoked between lock_res=
et_domain and unlock_reset_domain during GPU reset. While this might be saf=
e for ASICs where the driver directly reads registers to query the RAS erro=
r count, it could introduce issues for ASICs that retrieve the count via SM=
U. If we keep this function call here, we may need to skip the RAS error in=
fo querying operation for those SMU-based ASIC types when harvesting suppor=
ted.


_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, November 13, 2026 11:46 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org; Sun,=
 Ce(Overlord) <Ce.Sun@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset p=
ath


AMD General



Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>

I'm concerned about the current amdgpu_uniras_query_block_ecc implementatio=
n. RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and s=
hould not be invoked in the current UniRAS code path. Using it in a bare-me=
tal environment would trigger an unsupported RAS command error and could ca=
use GPU reset to fail.

Could we evaluate updating amdgpu_persistent_edc_harvesting_supported to pr=
event inappropriate calls to amdgpu_uniras_query_block_ecc? We should also =
consider adding an explicit check to ensure that amdgpu_uniras_query_block_=
ecc is called only for SR-IOV VFs, or retiring the function if it is no lon=
ger needed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Ce Sun
Sent: Friday, November 13, 2026 11:28 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Sun, Ce(Overlord) =
<Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.com<=
mailto:YiPeng.Chai@amd.com>>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset=
.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
        if (!amdgpu_persistent_edc_harvesting_supported(adev))
                return 0;

+       if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+            amdgpu_uniras_enabled(adev))
+               return 0;
+
        if (amdgpu_ras_query_error_status(adev, &info) !=3D 0)
                drm_warn(adev_to_drm(adev), "RAS init query failure");

--
2.34.1


--_000_BN9PR12MB5306239C483D208A1FCC8267FC7C2BN9PR12MB5306namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Aptos" size=3D"3"><span style=3D"font-size:12pt;">BM rea=
ds the RAS error count for each block via sysfs/debugfs nodes, which ultima=
tely calls amdgpu_uniras_query_block_ecc. Therefore, adding an SR-IOV check=
 inside amdgpu_uniras_query_block_ecc()
might not be appropriate.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Aptos" size=3D"3"><span style=3D"font-size:12pt;">Furthe=
rmore, amdgpu_persistent_edc_harvesting() is invoked between lock_reset_dom=
ain and unlock_reset_domain during GPU reset. While this might be safe for =
ASICs where the driver directly reads
registers to query the RAS error count, it could introduce issues for ASICs=
 that retrieve the count via SMU. If we keep this function call here, we ma=
y need to skip the RAS error info querying operation for those SMU-based AS=
IC types when harvesting supported.
</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Friday, November 13, 2026 11:46 PM<br>

<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Ch=
ai@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU =
reset path</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Calibri" c=
olor=3D"blue">AMD General<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:Ce.Sun@amd.com"><a name=3D"_@_023FD7B1FEA04F598248936E0920=
E9E6"></a><font color=3D"#2B579A"><span style=3D"background-color:#E1DFDD;"=
>@Sun, Ce(Overlord)</span></font></a></span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I&#8=
217;m concerned about the current amdgpu_uniras_query_block_ecc implementat=
ion. RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and=
 should not be invoked in the current UniRAS
code path. Using it in a bare-metal environment would trigger an unsupporte=
d RAS command error and could cause GPU reset to fail.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Coul=
d we evaluate updating amdgpu_persistent_edc_harvesting_supported to preven=
t inappropriate calls to amdgpu_uniras_query_block_ecc? We should also cons=
ider adding an explicit check to ensure
that amdgpu_uniras_query_block_ecc is called only for SR-IOV VFs, or retiri=
ng the function if it is no longer needed.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
<font color=3D"#467886"><u>amd-gfx-bounces@lists.freedesktop.org</u></font>=
</a>&gt; On Behalf Of Ce Sun<br>

Sent: Friday, November 13, 2026 11:28 AM<br>

To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#467886=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>

Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=
=3D"#467886"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a=
 href=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#467886"><u>Tao.Zhou1@amd=
.com</u></font></a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd=
.com"><font color=3D"#467886"><u>Ce.Sun@amd.com</u></font></a>&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#467=
886"><u>YiPeng.Chai@amd.com</u></font></a>&gt;<br>

Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path<=
/span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_uniras_query_block_ecc doesn't support being called during GPU reset.</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Ch=
ai@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 4 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 08c6e55a7927..7be33d5559ab 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgp=
u_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_persistent_edc_har=
vesting_supported(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_in_reset(adev) || amdgpu_ras_=
in_recovery(adev)) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_unir=
as_enabled(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_query_error_sta=
tus(adev, &amp;info) !=3D 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; drm_warn(adev_to_drm(adev), &quot;RAS init query failure&=
quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-- <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5306239C483D208A1FCC8267FC7C2BN9PR12MB5306namp_--
