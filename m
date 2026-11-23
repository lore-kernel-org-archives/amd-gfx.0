Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04999606A326
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F1MsUsJn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540A410E6FC;
	Mon, 23 Nov 2026 20:14:59 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8462E10E6FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 20:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAEaEGtz2GEmA569VFKWRZZcnBDHVQ+JnUu6XZD6S0SUZakUnmtyV+LpjldhofMZXlAYh2FjG/oVKi1Ly3YIpp1TondprvFw9hzIpnySpVnq/4HO6RwyXRkQStUFLqJjemSP2BQz0p7OhSkEFFwk0/fXjp96OFUM1wQeXDXLmsuvub+YzLEvGqX87XW1iURLIXanIUK8l9m+rSkIUe4JBibvwGPLySg1g+pz+5DXboGognAQJ3yMp3GiK+7kvqacTCS66tC6IqaUE/fEasQ6CmrjV0fFzcX8j0r/SJYN8E0BzUJqIuO7G3/IG5gP1smDCUpej7Ar9Zl2ZZyRMNzW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPmBRqnEPBP+LG2pGEefXLW0J1dHHVl1SPeklh0gWHo=;
 b=uyKECfrqFucHr5eAgdvtjJk5cQaM9H8fgTROYx257JCtXjazx5H3gaXtmvi+9DCOsBTUvdKjLz56nNkhKV4y5vcs03d8zOodSrhDwXmrDjjHNSMAggUIJi3qS4c/kqmzhkTBJh36EqrDRuuj18ZCBjlyltdiE21xTX8ngQLJPD9jU8B4oJic3FYqgOSGdoyzXZJ7u08ACjdoQ8l5J1u6Bkb9cZknosZZg5GXJW5ipT+gA5Du7uHur0HfDZ8g6WB03aXWIUR3gJDyjwbHN1huFZwXldfKCtFB6opSCiHTwr9e9KEjdWg0yUvyn5jZiDrS+qHS2YgZXlw6G3ZMWs2/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPmBRqnEPBP+LG2pGEefXLW0J1dHHVl1SPeklh0gWHo=;
 b=F1MsUsJnaFPK1MWE0e3sySX7Q0QyWHfM1hX9JeXA4G46N74kcZ6m122CBAvAQ64T+Pxivfl4zQIP5kGO5TPwQTxkKbG3pBHUZdpXUD0xMFF+1a/0k2sO97NkWYPb2/FSXwS4qJbHb4jI2CnAIQ9HJ87HLTAVzH9aqkMHDjJlU+Y=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 20:14:48 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%4]) with mapi id 15.21.0615.013; Mon, 23 Nov 2026
 20:14:48 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU
 restore
Thread-Topic: [PATCH] drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU
 restore
Thread-Index: AQHde4B0BD9W0+hBkUOmzn+NsNL16bc8F3xQ
Date: Mon, 23 Nov 2026 20:14:48 +0000
Message-ID: <SA0PR12MB439772E01B88522E0703700395452@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20261123192532.2062064-1-David.Francis@amd.com>
In-Reply-To: <20261123192532.2062064-1-David.Francis@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-23T20:14:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|SA1PR12MB6919:EE_
x-ms-office365-filtering-correlation-id: b0053292-f8b1-4827-c21b-08df499e6c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: o3LEJarjV2nwehZmVSepvEXzQIBzuIpU9d5La9y0cNg4/AjGbTF/LreVdRdk1dEVudxAj4DVqiwJ8aV9bBcGgDuPCsFsSnmDcJ/GyQBLWM1Q20RJLmpw5uiiN7FL+bWq4sB6Qp9n+XxpHKTBW9qdEpKI8ym53QK9Cj6RYXau6ghuGDNgnnCUIap46pWCdBbcJGwDzOD+qV5cYf4SnGyWH/Vueh4ksNBOPU+jc9Gfnf2NndT+IyWnOUxg894NtrGgsKoafduXGkRvGDqlXZZLfQNrSYBz+4hLyBg1HrydztM2iHhHUSG4spcibDHpIHwHeLm+WDyBm4wJgH2EuoL0U+zaWjuyXL6IiyZROI88QukuKk5W8u/aTCDW+u1NkX3omQX00Viejdq9MgdRrJoFe+oHLkGY37LGbUsdVSjSrkzVsGJDDr6dEe8gp16Re1W/yf/0+w/JeYe6hrxl16RFNAel6Na0uqo0JtAEBlOfmZ2Vs5FSlF70+yJRfBE5aIvBG+1q7kgdVo4UMZBeB9SQ9H+SYBXYfYQo++V97D/MT6/eh5CY3crepdQLz0TVhuqyAAqzzmEcEoHxofInU/ERsb2i2S+RBbqcI16BgUumSVi7fQhafQG2d9Y5NvL05ojlTK+h95WZCj1Qqlt2sVDKxsTnbcnN3AzjZGZlPxxKuslfdDoGPQdb4gBBfKomnW4seqz7mSqry1kOIl1MknX75IH5UNQrUPONcupuveMBZnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gn6pmjQRpBDeppk4xS28LWfi83IhP6jTwKy67H/30DrLOfAsJFGg/SiQ2+L/?=
 =?us-ascii?Q?wqlEq72GXFNt9Jw8IOz5KMAqGwAMDZ1IG4WFVP86cs4O3W4r1FiLZIGlK5/J?=
 =?us-ascii?Q?T+U1QgveMZ0NZjnyujnkzyxYWWrwOmaqRmfgCsDH8/KVYT46QMqCP+HGAg2e?=
 =?us-ascii?Q?krZro4ltL/f/4ILJXm/yWVXv7fNB192nTQnUPLn8GlYSlF0CwxOfyvm++UNg?=
 =?us-ascii?Q?PHb0x+A3lVI3ehOWRXoSrpVq3fsfyp1ReKhaLtkBoMvoyYa4StqmYaOLaC8y?=
 =?us-ascii?Q?S2XYkGhJ+Xes8PkMViDqHM8nYb9MMZdO9DgIzvMZnZNGXsPLrysvEq/sMlHM?=
 =?us-ascii?Q?+wnU7F3C7xaorfIMdMV8UAmwtlUCmFMxjQ6/Zg+6O9fI0zQD0JNq9ZtZWAoS?=
 =?us-ascii?Q?iyo++Reb4ai66ud3+SMGAvSs+AvjKXnb87C6reLLo50oxMzLaCuqe7VbXnRb?=
 =?us-ascii?Q?aJnowNGIxm1hlkUgA1uDgfebBGmfltiOT2+sWIYgIY5fKmLVT/B6vo6tjaCc?=
 =?us-ascii?Q?XG2f0DN2pgg9FUBEwNfBffLTObc5DQTz8SXL+5mCq5fqF5oiFRsAIKF6seBO?=
 =?us-ascii?Q?weecFBmhL9aHmw5tJsS8pUCDlfmd682CczqHeOjKlgkHZnKAPe9SeiC8oirA?=
 =?us-ascii?Q?sTVEd0xRrM1ZV3/0W5be9rWbMDn93Kyh1iO8yAQaFbDRHhAoIkQGl4gjdTrQ?=
 =?us-ascii?Q?VjH+FMHqjA1UWpp629M1e+7XMiKUZSWm05lMm5z6LR58hj1jd1XJiCT/N9DA?=
 =?us-ascii?Q?BP20YRhNY5btQTzfIwlyG01GUfWVP5SzgeEO0UF9XWWjdNDzH3zrIkEzyG7F?=
 =?us-ascii?Q?mOBJbPm1O36zuQhQh7yI3L98CJajC8Il/6Prk19JIWePCp8sD+CpLVQu6Gz9?=
 =?us-ascii?Q?mPkp2/zBRL5jnGTbj3CVBKywOnws6CykOpqKjWdMM572W83Z6S+ELKaoNchJ?=
 =?us-ascii?Q?2TIOC55IVSIcCixr2WnvBKh3XXp/W5nzhCMeHGAJbk9vVUBTSQqNBP/zREu8?=
 =?us-ascii?Q?GhHxpETWl3L5lwmQOBTqQv0i6RBlZAbFjgiR4m5NvqLJcVLQIkiJ+ZAymkJs?=
 =?us-ascii?Q?ICXXDSz2XtmfM11fioYQG3ckBPyWUEwwWBrcchCsJT9/Gd9/tAal4QHRWzH6?=
 =?us-ascii?Q?66A9yPGDhQ5BprPgn8o2AvmaybzNosBHVB8qOpctDTw7ntbG76pCygbbpHHr?=
 =?us-ascii?Q?0uEfHclFDJSnpnh9QbqjMRhq9YSsFy5tJWAcJyRl844DZHkVxnMIFF73YL/I?=
 =?us-ascii?Q?ye4uFD8Q5DEZFc4Xn5/VKAdxQKKVunDcg2m+yaTC1je722WIo6HTzxDqdib3?=
 =?us-ascii?Q?VlhwesQWPhRIT41ClLXFQWMfngTrcBVus80gqM4LoTnXASpPPfqUMfn8lYPR?=
 =?us-ascii?Q?T2l1vUg2q5SU3p6XjnV1stQkXzpvT91u9rBiRVCsJxGMCFsNrl3hgItx5hCk?=
 =?us-ascii?Q?j/jV+9DdNjhrm37agDN7m5zLs14zWm6uEo5MZmPrBay5piv3kYSJypkORhEM?=
 =?us-ascii?Q?zZDlB4IirolYez+yCf83hebdKNJ9rDXrQNJKRbi35ylQjahVEY0oCFpk9xLV?=
 =?us-ascii?Q?oBFB1nFu0CPEmpGRNSp3Po0x2cDXypar3QCZnnmpZ5gNoSwqj52IUhdFMGVf?=
 =?us-ascii?Q?Mr8pSRb/8ggvbjB+DsT3Zp/DAPGMQHRXtv01n/qdeJxVnBFnxkw/ZFgb5t/u?=
 =?us-ascii?Q?HdwSMMMoDZbe1dQSF5vDg68deB3/m+bAPgJnhjB71hhJWYMr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0053292-f8b1-4827-c21b-08df499e6c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 20:14:48.0574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLyvyiuQluzg3GqyCH0dBGYPDSL4QjKAzYi2qXBgB/r43VtogonqpjIcT8Z3SmungKW1SaW3y+lph2BrkAhKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: David Yat Sin <david.yatsin@amd.com>

> -----Original Message-----
> From: Francis, David <David.Francis@amd.com>
> Sent: Monday, November 23, 2026 2:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>; Yat Sin, David
> <David.YatSin@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU =
restore
>
> kfd_criu_restore_queue validates that a CRIU restore has the correct mqd =
size, but
> doesn't correctly handle that the mqd will be scaled but the number of xc=
cs.
>
> Change the check to handle multiple xccs correctly.
>
> Cc: David Yat Sin <david.yatsin@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Fixes: 47ea05f246be ("drm/amdkfd: Check bounds on CRIU restore queue type=
 and
> mqd size")
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6cc0365e9b11..6a9d7d31c8d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1030,7 +1030,8 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>               goto exit;
>       }
>
> -     if (q_data->mqd_size !=3D mqd_size_from_queue_type(pdd->dev->dqm,
> q_data->type)) {
> +     if (q_data->mqd_size !=3D mqd_size_from_queue_type(pdd->dev->dqm,
> q_data->type) *
> +                     NUM_XCC(pdd->dev->xcc_mask)) {
>               ret =3D -EINVAL;
>               goto exit;
>       }
> --
> 2.34.1

