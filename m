Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E553C6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 08:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF8710E2EE;
	Tue, 21 Feb 2023 08:14:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1AA10E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 08:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuonacI+9WnbsFDBlKuwPi6T81g161YAPndnLFT2Gkl+KvhwdPCBlb6YtGX7V44867VZBA4lBou9w6/IiFnrDXR0T2MKDAVHkEW+mCOW8Z8wGZ26yZJ0y7bTZ9b9emJhbXNsdAgsHchPiNodGDoijEWoOi+IBDXqnmGfvtnEnpM+Se2KOI55h9rDsSbFyLWoV7MaDFVvoUcWJdEZjVZZcaiNsaVLfTH1RTE4osz5/fzaF7o1zJx1/5mzW0Y3f3ydyFTYczCPTonHnJdjx8HSzcUEPVlIGO8FrZrYzS0oaqSITu774ZSd07JFSD552ej5+9oJMyujbC2yP/VrAp2abQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suAeaK7d6OKzNzuBSXjhM1KnaKkj3Rp5OsgJmRJh97Q=;
 b=bIC745pKi2kHG89QbEZOnnDXwgBN1kg5PRetWle9jNN9+Bn1UmdaDOFdj6wYKSAwYNBKLieDj+ftIOIrzpaY9Rpnn4tN85ljMOMpufTMnKjDhRYzqDTjrAim+3tw1Jf1a4lSDlrumuJnG9OjlMGM5ZWw6USakEfTU5jAZKAZCWNfhk5AaUGfQ0+NDztlGoMEp/c/DLLTtVMwnMjVaatkKjrxgTRKxvVBzixn2jsQOdy9guZentmRyEFDzJUWV7lYQKqY6UEwjnc3fXJtrrBf3DZSON8Va75a1/BjnzxdMR7Vw0ZEh23Wg2YXVYU3NviT+T1WHgq9qmSCdRZA4KcuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suAeaK7d6OKzNzuBSXjhM1KnaKkj3Rp5OsgJmRJh97Q=;
 b=F0Os4/elW/Py2cQTa/TuEQcUd4M36qe1rj5I2UDxCSEQ0NzMAILRES5li86MblBh83AjomeGJDZFHJcL6SKia51lMZIXRfaSmYDP441ECdiP54YLGSuMWatFf6Juieqz3ctS+59WouMhwog++rkU+Nkg3iF7L8/C+Z953PK478I=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 08:14:01 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::7e90:73d5:aa84:5d73]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::7e90:73d5:aa84:5d73%3]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 08:14:00 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: no pptable resetup on runpm exiting
Thread-Topic: [PATCH 2/2] drm/amd/pm: no pptable resetup on runpm exiting
Thread-Index: AQHZRclegANqc+j2bkGQuLS+OOyv8K7ZDUIg
Date: Tue, 21 Feb 2023 08:14:00 +0000
Message-ID: <CH2PR12MB4152F77E19842BE086109B4CFEA59@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230221075123.1831895-1-evan.quan@amd.com>
 <20230221075123.1831895-2-evan.quan@amd.com>
In-Reply-To: <20230221075123.1831895-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH2PR12MB4908:EE_
x-ms-office365-filtering-correlation-id: 7d7d5887-25be-458c-8b61-08db13e39675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9r40LNRp5yv0v3Hn7SKEpUfXAm9Ip1p1X/+F+kW7wYoj7Y6k91VU2qKPuDOcP+CE33zgYKi+4cMaA0s74GL6f0Tce2Yxa6pvDIKn8QT8Pcv4ZmJSrjwLsppJEzQ0mcg2jiz7nedY4lmyyTMiAb1KYwN8aIrZhkYwpY3fTVziO7hqHd0G56Pd1lAvq7eyhM2sRUvZTCQCjbwfYnVGfBkynT3hWkqN++s/l94ySA/v/kkpJ416l/UZO8zEQpQYtp99pbJNWlAHrlGSKe/xjCb9hqv0DhXtx0rKfkff/Dbu8gTtBS+3yZ1DC0oW+lg5bPD8Rd98rf5NpQpN9gsW7OUxM3b9u2bnn8cVgtO4/J69tmdy5LTyycVjaL6f6gV/Ysp+2tvutEl1s8cal5b/pw0nK+KJrcHW5RhN6ObxgrefKUwiCWLBt9tHLw6IDBA9Qfi6GCjMtPjmNnt86/cCwKRXtGAk9ACiRttQqpInZCERB+ibY67sb4qMHhtbe7CJhmv88jextaZeZn3llhkzUTKqKH+JfAbew+NdgLy2KtCLsfoZQNEARru7l6hLc4wWNGKwT1xnBRBJAesbiNd2Nrk/5xDpcxUFjp7RrLm1NdhbZE+srVQjn3FP42ujPx5rR5e6sN72HyHZ/QhBzTTbFn9HRaTxFdU0BvCY8LSvrMRqnkxGU7CHJl8PVdBK/q7Md1YOqTUKunpOdZjt35MvqQBbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(83380400001)(122000001)(38070700005)(86362001)(33656002)(38100700002)(2906002)(8936002)(41300700001)(52536014)(5660300002)(26005)(53546011)(186003)(9686003)(55016003)(6506007)(4326008)(316002)(66556008)(76116006)(7696005)(66946007)(66476007)(66446008)(8676002)(71200400001)(110136005)(54906003)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Unh5tSveU25iITNu7S2uESmPUPMQSj4vLnS+dPcRbtGZtESngPH/nPsYW+AR?=
 =?us-ascii?Q?h0kbjm0HpF8tdjxfWEb5pPjifZGaoai7w/mZoKyQmdi1sCOadAPov0e2BUCm?=
 =?us-ascii?Q?Pkvwv9H7FAYdLrstq6i9q7zGzTcAENlTAWU7UGaMSHq2dBvOTjzRFtFo07C/?=
 =?us-ascii?Q?dMx/Cx+W1yd3To6pgKBmUyChZlv/kKDJJP4TkcQla6b3bEXtOTUZKMKGqRYf?=
 =?us-ascii?Q?szFZmhul0ED6SNidu7dBaaW2oGMhKesPCDnsNuk2j0na+M/g/Wwim838Y8YJ?=
 =?us-ascii?Q?ReIA5Y4l0wZQJh6s0EwlsgKP0FEupNeCvlR1/hAPcJpd2Dzls7Lm8xA6OP+W?=
 =?us-ascii?Q?qmRIYgrXCWlH6xQyDT3zsjzb0z35gyGVJeGPqe8DDUnvAad8W7pRcKmz9th2?=
 =?us-ascii?Q?W8nbHAsZWDkNkI/mTbQLfR6KSyO7q+qJa2PP6DkobD86zVIdsEH9xJiugsCl?=
 =?us-ascii?Q?lGX+WuKkIeMybFPJJeitEfMyxjFet8cm1sMN29D6ze6kGRIpvpF7o87fBHAC?=
 =?us-ascii?Q?Y8Z2XmPVv/SKl8zocNtKA0IFPlYOsuOlOQQYlXbccaaQ7mLsv2NyuccbDMvR?=
 =?us-ascii?Q?s1E6l+ghcOZrkp8YrZRuPLHUEGtSUUr/AH3mGvQFeQDC2fWXd//Jk7+Dp6Vi?=
 =?us-ascii?Q?ts4TxZ9XYHuRCSjtzXfJ1tbMnlE1uvyiH39mr+O/nlJCtGtRL99uWjYEYM6R?=
 =?us-ascii?Q?LL3lZA2kwM8NQgnmjq1gR32DYUhybLWde/ikl2bOEpPb/1VNb9WAonXDuqWB?=
 =?us-ascii?Q?pq2crjtf3QTJfN66h6zTt8q1OqCHC3PdfQY9P/rdbeGrrWTbkW4YRju64S99?=
 =?us-ascii?Q?NNkanjfuY5hK7zSrA+jEpN5uYPunru3nR5av8JXCdPvSjNI9LaCOo/3tGM8t?=
 =?us-ascii?Q?P5FLOoRAS9lu2GBjo1oaqH4wGcC3y5Xfrjr3TZseq6xGsX2Z0xSFRjgvkm2Z?=
 =?us-ascii?Q?WDBUDpSlHD4xtR0YEIGfwTYO4n2zIXsWbcfcMscbfD/9w4Zx+Q9wm4lsk9Kd?=
 =?us-ascii?Q?h0INIKvn9uGntC2WntYU61ZIgCNdOcfl8Z6PcnK/cuJfwYqwy7wPDtV7+uTn?=
 =?us-ascii?Q?B1VW72aG7to2g65ANzqvjWz2XlEDrGgrORiH0z4gu+A2auLd0rgGYjrwxLfp?=
 =?us-ascii?Q?lwu7C2kklnn9V6oC/L1r9FBmR85uHHlyUPioaiY4Luu9Bqw4tkXSZ0yDn+0N?=
 =?us-ascii?Q?ENwBIxYsrEYeuFTjxAycloHpE+95Fr8jDRRM/1v6Xb977UP6j9spHegmvepl?=
 =?us-ascii?Q?I4Vn3oJ1oGQkb02yo1ijDO5XfPTBWeFqGy8oCxMJFWT0Rj+Dx1qO0XNRxn+m?=
 =?us-ascii?Q?5Z6fQ7GA3CpCOqfJUKV0HG+q9urJ4KO797ajwumZ8zqQX6SuuL6f4GGoRjHE?=
 =?us-ascii?Q?rn+IbtWczm9lN54IbVPgOAmIYfwpL9miNb8mv7juckYZlslYlaLTFiw0hpj5?=
 =?us-ascii?Q?+PrNt6bS7ECGAX52MB1PvMk0h6trJVcJjMMRxmdqHyKcJ0loniq/J2BbTl2N?=
 =?us-ascii?Q?E9ZqTEpYk6Tr/pJ3zegk0NmAMzl11YaZxz8+Avm/mdayfbXhekwQjJdZA3zb?=
 =?us-ascii?Q?z70S4AzF+FEmMfBI81s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7d5887-25be-458c-8b61-08db13e39675
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:14:00.5222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRPA+SZAekJ+swQdoAnUDREZxER2qaIxxWvo7Mpjyn9YNS4qGbjFScK91vbtb2ts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, February 21, 2023 3:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 2/2] drm/amd/pm: no pptable resetup on runpm exiting

It is assumed the pptable used before runpm is same as the one used afterwa=
rds. Thus, we can reuse the stored copy and do not need to resetup the ppta=
ble again.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ib6d61f8e8cb58df45d9e24725b0672239b3ff653
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ff806a2e804f..bb25f14f0733 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1220,10 +1220,17 @@ static int smu_smc_hw_setup(struct smu_context *smu=
)
 		return ret;
 	}
=20
-	ret =3D smu_setup_pptable(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup pptable!\n");
-		return ret;
+	/*
+	 * It is assumed the pptable used before runpm is same as
+	 * the one used afterwards. Thus, we can reuse the stored
+	 * copy and do not need to resetup the pptable again.
+	 */
+	if (!adev->in_runpm) {
+		ret =3D smu_setup_pptable(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to setup pptable!\n");
+			return ret;
+		}
 	}
=20
 	/* smu_dump_pptable(smu); */
--
2.34.1

