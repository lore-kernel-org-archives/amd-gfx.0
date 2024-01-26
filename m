Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89813C47DDF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 01:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E1210E073;
	Fri, 26 Jan 2024 01:27:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3F010E073
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 01:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhovmuFm8aU4At1x23qgeb61Wgln2aZFknSfjudEldlS/U7vD9xF70nI8HXoD2a6QRpX4oqwJQqr3j1eSbnO80xNJltN3uJCga8xNIe5+/IIfQmOZmYsUbgh5EUg0mMlrygzoKqm/OYmEZKJEjfKu4/nf4djfoRIj1KDNWGfcsSqDqJeSayjsuEKIqfOokold56rh2l7UIH/F0gdtBzZ6fKpNQm00Xslidj7X+05KQ51vPAC6xF+NE3NWFOugQgI+vd9hc1JFXDGMVjVJCyHiMi1IWizHE1hdE4YvOcIw/NK1khnxM3zH3hctEwczLS5bPHOo/i1UZRpx+7CW6163w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NdZOT/gB/afhDEiRWam4s5+bqyH4JRqDiaOhY1UrhU=;
 b=m1Q4zeUOk3zFfmgd+1pAHESa0G/kdNhsKhvMpUOULwDimxdkoWmZiz7HMiVQs1ZUBTa6w6KUS8GfoBQRBHRvJ5rzXhNf2kbXjumgZgXzFKVVN7QvunW15DN0B6spaMgim4/aqc3PG234L9Ibo0GEn7TGpcN+pTXbe4glPT07ETiwFcOdP/9V+jZl+1gJ8QnU4NJPnEn0PbiJ6Iju9/ZPTycDORWlHS5StQYL00fDVi5zDbjzKcvlpTsR0VQv+LxH/Lzu4hRvPVLisY8dBczLBhnz2sqMgx+7tee4keO8ybHi1gg4dpNOAybUFAd6+Iy059E6+Sfz6fcEyxXoEvyPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NdZOT/gB/afhDEiRWam4s5+bqyH4JRqDiaOhY1UrhU=;
 b=uKA8kmTBTiOXQMS8xJmG/G2HaUbu5KM6webJ3jAUQHlXw0QuF90eV9iDJeIX8iFL2Gz++R9gWdQ5zkOL+3UiBLUjqoYz77Ucw90Dg+sjBPtt1xmc/1hFFpj0R8UbQip0ljQIuBnIHrCw7UBfO+kM6T6cXPkWtaTlhIWJ/cn6xqw=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 01:27:17 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::666d:81e0:86d1:6483]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::666d:81e0:86d1:6483%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 01:27:17 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update documentation on new chips
Thread-Topic: [PATCH] drm/amdgpu: update documentation on new chips
Thread-Index: AQHaSkfDyQVWpAHcC0ur5tKaun7+WbDrWPUA
Date: Fri, 26 Jan 2024 01:27:17 +0000
Message-ID: <CH2PR12MB41527B617B1B08A7E0885120FE792@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240118195106.3669705-1-alexander.deucher@amd.com>
In-Reply-To: <20240118195106.3669705-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=34306538-5b75-453b-b351-4ce97c1bba6d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T01:27:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM3PR12MB9286:EE_
x-ms-office365-filtering-correlation-id: 7da6aa29-14d4-46d1-9a68-08dc1e0deeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jo8zqVvVpfAZu5FWxTrB29WXEjDEJlri35uJb3oEgUBWMJLEeAd+LFv6NaIQTokpQ6wL0xeOf31tRmJjqN+sYXo99jUJKVf5j8H2/MlEFS5/hG8Xpt7pVo07crON7zuc3nev+1cZa3McNzYRIKxTXoR/5/+NLT0W3HlqT5nEzP+sZAMevORUJoOlFj7JRSz2aux2bd/VK/9Y9eiDF0EZzcPWlTYzivlVRBvcztngQqKigcMx4GyAeoG7YTWQyZ2zcu7KuVth8LxdIXzO4QNLoRWsER3VMREQ3ajnB0hCHhyddvCBH/jQnVsUppsJuQt7VLJbko1gRpgVLED2Or/Czp13ANUe9xGOscNrpAl86La2WdEX4bo8DlgH5115vU3xuhLdeoOdSnUAC80gaGbUVSZPwRyIZjclN8yhNpS55x8RuR4h9x4GhlZciYZGgNlWjSdXCxutZsNGbbG5ndLlRq+yi3toNvi9rc5PmQPdSoZqiLGRl5bzxPkGE1P7OTxnuJ3y9NXewt3+pHfcqgaoCmeVzf0/NDWDy2mRXQABsGL3HXKLaTbv+mf6iDwF8NKsI+tmGzcmlAPGn5YF3u/RVmHA+C6EfA5RugEsExE1EG/ol2GKveeZ3ZzxYwOLTsDIsFdfpqJiRLWbgxwj6X+opA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(15650500001)(33656002)(83380400001)(2906002)(52536014)(5660300002)(4326008)(122000001)(8676002)(38070700009)(41300700001)(478600001)(38100700002)(66556008)(66946007)(64756008)(66476007)(316002)(53546011)(110136005)(76116006)(86362001)(9686003)(71200400001)(55016003)(66446008)(7696005)(6506007)(26005)(8936002)(545624020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hW+ba6ZWK5RsN0jGnnNydwzbqCLlsQsjMG3Nvl0wFQRW+EKzX+0wMJb0TZo5?=
 =?us-ascii?Q?It+x5xdi8wli+J0LELw53SYfokL7bYh1FBeH7LVNvBLUTRSryaZhsleb1o+h?=
 =?us-ascii?Q?YIU1Pz3RLgnRa8/MTxmrvUXCR3pdguVVHvVDAHqaar4laMZn84N0Cbe0aexw?=
 =?us-ascii?Q?+75bkjXXLh/Pts/ZicL1Mj28cGWuNCqcAHj+EhCrxqM58KWdwb+1swotcpg6?=
 =?us-ascii?Q?1lKkvew1pFKYKQ2YlI/YP7nkq2ME9F8KLv/2gJFmG5F7r4GXDnZvEyFlvROQ?=
 =?us-ascii?Q?kp7TBe3FfAhLvAO5SxzLa55wUlbOYoWVlefH5opCHVJmNaiHirCfeVVwzLqu?=
 =?us-ascii?Q?2WiJAr+90WShtpACWFfp07U+Aq3P7Dl5PdomzAhEiJviPm+8Q+39E1Nfj+A5?=
 =?us-ascii?Q?J3Wn/csXRzUnB0MS+z7hmT7y5pB37dsRNoR+3yKqkt9xEVxP6Vf7uI2owoE0?=
 =?us-ascii?Q?Ev6/crQkVrK9BJOdmavVEez18sx+5TRkcDm5PHBkF5QbWaslLQNUmNu52rII?=
 =?us-ascii?Q?q3Y9TgLZ2IbHezKSE9zs0Aqqic39H8naPogE6bik8Y/nYaYDLJtELLNB3xfV?=
 =?us-ascii?Q?GBa3HCyfZViQYDc/sCTQ6ZVXZb/11YVf84od/EqVcAl1sYQbE1TASFM/W5Mb?=
 =?us-ascii?Q?p4/WIz947LSYnBR6ipKuyW2hFMUdPpBBu1NvchkMbH2Lb1+bMh/85e762Qgw?=
 =?us-ascii?Q?2tHOZMKxfb+4j7sz8yXadb0jd6CRgpa2pawudDFFkqQbBDbU2vKkEV0zFTeA?=
 =?us-ascii?Q?h5mk/h+ihjZzJaajCpIc5Yyj4dA4q/Xx4t/X0+EB+KYpUtroOPQov8mxaY8z?=
 =?us-ascii?Q?lIx245cheHBHjf4c7OQPUvE+J5BlhCDg/zpdeGux6Y9pFWIfGfo2WgIAEoyT?=
 =?us-ascii?Q?Ee0zLT0El+fH3CCiK6+6W4UNcLvInFOzFrwfjxnCNfXBTrwwIP7rfSsn+RPC?=
 =?us-ascii?Q?6uzG6kK3HDLRInmS4CSd4I6lWvIIOAdeE1q9+GTnISgcI1/HyOZPFtVP42Z1?=
 =?us-ascii?Q?UTiJaWyUpC0b95CIb8IzoBtzqWUVBMpb/OTa2U2Zn0wJOuzpCCfmEj9NdLyG?=
 =?us-ascii?Q?nuLXBp7Tpo4JwfWo5y6aCqlcnZsj/mWFlD2mTi9qg1UIJaHdSH7IVJDwAAlH?=
 =?us-ascii?Q?DVMill2uR6+aorglkUZI15olC/GC1HsGcIqgKOB5s+DuAOsk1HV/SwGh0bgW?=
 =?us-ascii?Q?vnTMfYAJpKFZ91UUr2v0A0/bgKdS9pUV0B3jZxlkBc9rWgJ37iWJekQ41qQQ?=
 =?us-ascii?Q?OIufKiYQsRCPFm2ENZPDaW5qyraFAaOqQL+912sHOeojJ69jFRvbCa01WFVf?=
 =?us-ascii?Q?U81e9xqqPqTkv90xYGy2SJX5PreP3+2B1fQGtiPaBrXkdPLGfoHi9DYPkWyq?=
 =?us-ascii?Q?xv9eW7dud5hAt/LDn+87PJbgnU3NVwcrFMQVL0N7YnGvWjENWj7ZCIANqhFi?=
 =?us-ascii?Q?Yu433PqI6jJc0KrafVaAIKdoJyWFkfkP/Jy6icPgQRp+W3etqGHXprA7MTrE?=
 =?us-ascii?Q?Q4a+211TFyalBxWpbjS67I95ILxxMsa6Aa10vu6PXFRIjyieOciL4TFO4nnq?=
 =?us-ascii?Q?gQja281+YlquhgmeaF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da6aa29-14d4-46d1-9a68-08dc1e0deeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 01:27:17.1361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mh984r1lBKnllAtsYQ556eTI1fWdy12qhMJKq2VjJc/t+qcdKYQJmxnVJFTgMmmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
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

[AMD Official Use Only - General]

Acked-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, January 19, 2024 3:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update documentation on new chips

These have been released now, so add them to the documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentat=
ion/gpu/amdgpu/dgpu-asic-info-table.csv
index 882d2518f8ed..3825f00ca9fe 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -16,6 +16,7 @@ Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /91=
00 /SSG MxGPU, VEGA10,  AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9=
.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0  MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4=
.2.2  MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
+MI300, AQUA_VANGARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
 AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0,=
 10.1.10, VCN 2.0.0, 5.0.0  AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W550=
0M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2  AMD Radeon RX 6800(=
XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0 @=
@ -23,4 +24,5 @@ AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN =
3.0.0, 10.3.2, VCN 3.0  AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGR=
EY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4  AMD Radeon RX 6500M /630=
0M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5  AMD R=
adeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
+AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3
 AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.=
0.2
--
2.42.0

