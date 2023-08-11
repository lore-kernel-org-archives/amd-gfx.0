Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16092EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 04:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A504610E63D;
	Fri, 11 Aug 2023 04:29:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC9010E63D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 04:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqixCSyPCR7qX1EwCfOMwgwPoyfOLxqPbzOYImEZqgibN+enkQQoOKVPwm+cTqN8z3I78YjQAphDRRE1Ov9m/B7X88VWtz6WMhZudWkSO/k4MnIa8q5WuvaO/iemunqvi70o33vfhfPmx9DkM7uAs4P+WyD3ZYeJJKgBEcNDwJTHARDqsE3lXtapPvkydkDJb+Ir8u2sqCpj4tgKpzrgWXJBbXjTGFZgns73679IAhcD8OmsYTzITwFELM0RbmTiR8mC5VfnER3PC/J8i/sAoQSS80fGdrmB7XjxqAzziWcPX3eCMCP5UFci9RFgRWYnnnPrJZUYNFhhh2pLZxRWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSUBpgD587CV/KSuOUXD2j4RXpYKclLvpV2bS1w1hHU=;
 b=hm3jzwxlTXIInj8zUMS3wkdfe83eINXPyFoX1oqUTNpbDvsSbZ32C1izqltNpmV9wdYWbmK6ow+AstPBMvZnq2EuoQnLp5Bu4b4l0tI35UoKndIIepuH4yKcsq7B41wjS0ngoCGKBt5MLks2Z5Fn0q5DKnfwYxPgn+5rIvHxM15iZ7wAWsKJOCpIDcanNQE831ckhfSrYogwH4FYt1HbJma10sR5rCghxm0SVXjpx7Ex328j7qx41EKoKRCByqVQ1LQ7Be6eTWZ6NxeJ2xpYnJTT8xKZk0CLqfwJ25S3e/C3sq4F485zM7xGzk33d+gBYBI3V/6wj4DeU63NsZ8iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSUBpgD587CV/KSuOUXD2j4RXpYKclLvpV2bS1w1hHU=;
 b=5ej4uOJIbOSnlSjpXAqYK1Wwj3043DRFOCrmO2FijIC5ohkjzItOmqTblsRo8b/MEB2HDfy3mFCameuQPIh224d3VToYyo0qjp3J4wZKDdJDDoI9ZwgKkPMvSxlxpvnkKr3sEn74uHyqZu9j1DFMer6PDJEcuYwqSAoze+8XcTU=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 04:29:37 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::e6bf:3349:8377:1eb4]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::e6bf:3349:8377:1eb4%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 04:29:36 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add unique_id for gc 11.0.3
Thread-Topic: [PATCH] drm/amd/pm: add unique_id for gc 11.0.3
Thread-Index: AQHZzAxBWU8nEUWmEECq9mrdcDB4+K/kgLEQ
Date: Fri, 11 Aug 2023 04:29:36 +0000
Message-ID: <CH2PR12MB4152A644B3CB746399AE6A0EFE10A@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230811042806.767993-1-kenneth.feng@amd.com>
In-Reply-To: <20230811042806.767993-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=97ee1708-61d1-4fbd-8be5-927e2b2adcee;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-11T04:29:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 743ed37e-8b03-4808-2590-08db9a239202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvpH3KL2CZCQPc7HsXNWDDS/IN+m0Cqrq0X1CeOhR7qmCUYT4gArn33wO9OEVAi+SoYuiurUovQheaYQKtyDiWXEMlpyFVa22L5ie5cE7zNDChbb12a7csoaknzLLre5xuOQAs8yuL4O+BMjHaaZxrJ/Rst4rFdDpv9kTaZu1z+cEOCSdQiCDujOU0E01oJkKoDOH0iIsoa8QhAeEgB2nhwqX/QJ76I4gBgcvzSnfkaSqg4Umqp/SY1FOPhWxLAs7qjH+RagzYOzd5+nqjQhmXRaKF0y8CHWHvYyzHbg+XJ0uDNLkzKMXvKE5S44nxLxA+wtPVhlLrttnGA+civyGhv9Lrj9sRUZs93U2CRj5GwbPbswHhM7azwvK5t6hiHLYloBoDJikvJFW1jgvW8CT96fQ38Kh1cSdr5wXCynqHE1FwsCTL/tQARleqnHUEiDYzSMcDp8lTF5zdaQRw5nGW3KnnaXhJ62pqYDqM63NBxcdKR1yAzVAG+y+zI4jehLkq+dRtcbYxrm59TnSIGwNwqnSFwlJ+4qLiiFJ0+oU54p+NKAXngrYP2HxweDQsS9yAvGsWMCb7oDv8U8DOzkfnFqhBJXu6V/kTYV8MJ7IaJg+KU3npzPyTBsh/r9gryx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(186006)(451199021)(1800799006)(26005)(316002)(76116006)(66946007)(83380400001)(110136005)(478600001)(71200400001)(7696005)(38070700005)(53546011)(6506007)(38100700002)(4326008)(66476007)(66556008)(64756008)(66446008)(8676002)(8936002)(122000001)(41300700001)(52536014)(5660300002)(4744005)(2906002)(9686003)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iRYH2jRqQ4y8SlVe4AG/eE4pj6mHvqUegT8IeVD93gbA954nYMDR0DVbK6DJ?=
 =?us-ascii?Q?See5bUa45djXZnJ4Q76iix7vvxf6bbsLA2r2rR+WRv6lH9oyRPPUNFewuTJx?=
 =?us-ascii?Q?1KII2wCuM6ELinbYOl+oBMjWA4KVHOu2Mvgo9WSf6fwwzQxRvtAsaIT08B1d?=
 =?us-ascii?Q?Kzzoc0lbQzCAbGoMh+tzqhanKFiWNHuFPts6RItpt6jzYSeCDxg3wPO4GQb3?=
 =?us-ascii?Q?73g8tg/bQQ7BWlA1cbvCa6jG84UA40UadOPsZ5Q6dEJNi3ynjrSFa/soEsmH?=
 =?us-ascii?Q?yfuKm6hQQInrHim4+DtdzLh5m025OuHF5Fg6xRhFiUnVu4uRj0vXViCsw4Xt?=
 =?us-ascii?Q?895uQCAZj/3T/rkyWpN48bgELdrqKydaPysAN2A2l2jYkyN1PUDm96+eyhm/?=
 =?us-ascii?Q?cM6OmA8L596ce7+xDO3qyLHnSd2oSw7OnQ/3p0X/ZPXuQ14yFNmqQQkFgneZ?=
 =?us-ascii?Q?YGWImb0FNd3h9rsHmo4AzgrvyUVhl8VIq8atU72ljmxd9AzvYsImbfwnbkMz?=
 =?us-ascii?Q?wA4gi2CS5mQuXIBavB7nEih9FQo2RPjTosM/sToBPhJf2lN0VtCLAzUIQZlK?=
 =?us-ascii?Q?zQVwMudMbW5lzTRhtMLZ7rFwxX/bnOKwXR9dpr0ISFoO+HJFj6ctHh57q8Ah?=
 =?us-ascii?Q?SgjXvwn6rpivMlAFowwzAw/YK6Qx0rLdTl3M8UpI6yLgUQ17wDcwYHuUK4tl?=
 =?us-ascii?Q?GaGEut9gM2Hi3aoYNN/5xDn1NivowFcAJewxo6gasBhg8ac/QyZAGs7gPyE2?=
 =?us-ascii?Q?AbwokLOKdysRCXa148ift2v5im+pfsmCb15qJCCSFULgxVOOulPu/C1n8APU?=
 =?us-ascii?Q?RV2YZCFq6w5j6vT7egreDFUlb1KPyVaCqDypBZ00STA2Vvj9Xp5igylrpE9P?=
 =?us-ascii?Q?P6hcxHil3PWvPfQtrygWXVeuBpyp32C5/0yBcT9go1k3IiWdm4dbmEzfE0mf?=
 =?us-ascii?Q?7JU/Ki3TAMBE5tPtY90U0SoMYNeG2mX5TWKeVBV5iZyPN21U95qye6uO0NXg?=
 =?us-ascii?Q?CM/LuDwZKme7skJ4UG0PEC5CcoZaVcFhfrQl7dE06gd3nvuZx2u7KJJdfwVJ?=
 =?us-ascii?Q?7RaXaaj0Y0DQ0k36yTd2aAdV81/sjHrB5a+FjCB8fQMv8vtvcz0pPErwdDxA?=
 =?us-ascii?Q?p/be58t7KOf5y8c8cE3rxtYL497M1Fm4FyCs0xAFjLirSwyvB6zbKTIYeDMz?=
 =?us-ascii?Q?4N1nad9gggAWwoG5Nxh6r4ZU5zOhR+sC8WTaU3H/UvIkH91EYSOgFDYIeaf4?=
 =?us-ascii?Q?cro++0QGFVMwj0iIQsbfozzHLe9WDKL7d5khBH/2JAMx89URHrPOXDTZWd+S?=
 =?us-ascii?Q?t+Q8FHDkkuQsEzemrr4EtKGb85ipD89PANCL0yp9AmCwdeJSA6c9p7ee1jnE?=
 =?us-ascii?Q?YDH4V5F1cwIH0lsj2gndSPPWyBKokQZl8WzOe2R5+2KqTlb83iX1tWDg327D?=
 =?us-ascii?Q?Bdcrr5Cl9v8j1Zw7e1BQHMNcpFB9si+sELFvpdw5ItGX73Y0jIUtcnO2Zyd7?=
 =?us-ascii?Q?GJSfGPDgOOWzxrV5i8kZLzG4jIU3lmo/ixKtN/tjB+kaVuiRgAmfAJmEeKO5?=
 =?us-ascii?Q?CMIABOlmVj6C2POxuf4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743ed37e-8b03-4808-2590-08db9a239202
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 04:29:36.7072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEUvc/8e2w9Jjri9mOQrRlz2/R+GA0Yd0fh/6RXZZ9NTKECAKq8LScZ9bjOBR3RD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Friday, August 11, 2023 12:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: add unique_id for gc 11.0.3

drm/amd/pm: add unique_id for gc 11.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5aed023f7402..c69701da94ea 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2076,6 +2076,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                case IP_VERSION(11, 0, 0):
                case IP_VERSION(11, 0, 1):
                case IP_VERSION(11, 0, 2):
+               case IP_VERSION(11, 0, 3):
                        *states =3D ATTR_STATE_SUPPORTED;
                        break;
                default:
--
2.34.1

