Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AE9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 16:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BF310EEE4;
	Wed, 15 Dec 2021 16:15:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38A810EEE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 16:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeMqQKdd8GJX78eLopglXbGdT+rX7qu7bc9Q1Y+f0N/D93grx5+GcUomTPikXLOZ6vPUxkVkPKktE9lpal9K4UrNkAbg0NYbriVDsPkAkVu3AIwM6wLLmcbSGI4A1iTSpzqIU4GFimHHPjyO8z5Ayiq4d4l62MKR3/zvJPY4yoeDuVVrdnQexT6wd5DXxpq+WjCLiISHFWXeMjXLpfEsPoj3/4ZnSrsqMVH4NAWZ+1p+nWwwou6CkD8+R2iwbCB9EA8BTirvruXpStewknae8KN2UrnXt+vFXLlJPhqD8dGrGIlGRZSoLgNu8czXFXo7hn52AGsOT+g7z2iKWDG3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLcidT9XdKqqYrPw74eiIH6W5Gk3NWRkOqz9wq5Xw6M=;
 b=WQpHTg/6grzTqjC6EpPZz532ZU25wq2xl+ZR09F+7Xl9PPxgKIdl4UjtNNPQeskSU40x5wT4m9dIwtJ42NbpOf1h1Rv2/VWqIdpfOYaYpMcnpOulICwKN0kUR6b8kry4OEkQr+iQVpj40Gb0e3K8ipRxwBw8bXGBDQqtoc/wqGCZOo41+/0BtHpnbAPvkxEkWqv55s5X35Rguztj1miVzFTGzlGG7aFMcAyPY2M6yytlRKIiZCnoCPDRy/WSlbCqnwYLTlYRFXDMLwYmMvcUZKNIq8UXDQGouTARcqkJrIK/cnajqIynANq9Ugxp/6DS7BBZofMS8r6YzteZrsXULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLcidT9XdKqqYrPw74eiIH6W5Gk3NWRkOqz9wq5Xw6M=;
 b=agpzIiKCBM++MXhIo1eG8tZQELQPSywoDHC8FLoGG+oikA3h0GU2LqSeRVMEaURWFelIlrzLXQ1Qo7e9zRZkUYknFjaAZ8HlBaK2Q965xI+5vqut/dVHDy+WkSwXmMDqWSRYNOM8QDXPw25VDW5WhrxuJbXcbLe60oggvKJPEh0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 16:15:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%5]) with mapi id 15.20.4778.017; Wed, 15 Dec 2021
 16:15:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
Thread-Index: AQHX8ct+4It3JjIczEuwh3UygnaFmawzukYA
Date: Wed, 15 Dec 2021 16:15:33 +0000
Message-ID: <BN9PR12MB525797302268EAD67F442991FC769@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211215155015.615018-1-lijo.lazar@amd.com>
In-Reply-To: <20211215155015.615018-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1176097a-241d-4516-8a2b-08d9bfe61f4d
x-ms-traffictypediagnostic: BN9PR12MB5258:EE_
x-microsoft-antispam-prvs: <BN9PR12MB52584A16990759233CA449D5FC769@BN9PR12MB5258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROtyuSRVLZ1hRHjUrbcKF0ZpFq+6U8Dg0KwOsKxpqjtMyMVSZ7As2hazN4hLtPmHpAMuwLsQ2JasnI7ZJrXDjg0MapD/f7ukothwKODjZivT2RVeP0uRdhLmpKmPYQol4B1SP9thPyV5K8zuRPk+X+d5NS5yrGjf+M5a8HnC7z01DaR3kfaExPvXTaTjEEveAnG8Ejqq3liox3hwev1q3xPoi8cPdfFzs8GtsDbB/AAA0q3HGjIrS/N3Ge0OzZSvvy9qIHmSPgcwomceMmsCXvkPopVdaloQaY6FDAVNExfoYAA6qdwBh1SDTG/Ww2vfu3eRVZ4pIL/bBPtBtKeA3EMUxxWoneGvsmgVHImGh48oRVgod5VE789C3h7rGCJIjkGRur4hl87zJPPMZjEH7FqSCuwvqd6fAd5VyYZgQ0a9EoLdErbPLiKrSln8xvpFM5RguBTSwk9mUDAyWBTSModts8LURLWrrWvLo3cPvOhXwH6Iesnih44t8qvygWyBkA9J6E9d7gI1laJykSrWmlTkMO1M0xa33uhAp+kNr7ZUqGopdbgZrGhyU15MnF5uAX+lUNj8fJNwpEcP5iytnb/E98TjCOIg2XLfUzaxfZMthLFM7vNFghv4ihNZH7GISYKAJiYY5m70CF9nizdwaa7zkkMIxlK09Jyud5HdHdrLj8aWPvj/YFV49WV2SOtxdfDRyjyZ4uhdFs5Vivkqdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(64756008)(186003)(54906003)(53546011)(66446008)(508600001)(316002)(33656002)(66946007)(4326008)(55016003)(5660300002)(66476007)(7696005)(26005)(71200400001)(4744005)(6506007)(38100700002)(8936002)(66556008)(86362001)(83380400001)(76116006)(8676002)(122000001)(9686003)(2906002)(52536014)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdM9Xkd5Hke4BtXg5l2xuQJklkNSqmSsJ49mni8sGTMNQUclBHMrUhNPukuM?=
 =?us-ascii?Q?NLtHpDRiZ7idEHYl29/YSr/l3XEo3tCDj7iMW6pxzCIyTsllrkJ+qGiTAZiH?=
 =?us-ascii?Q?e60//n1/yhaZ2Obm4nudDpK38f5THgGGjRyL/n8z+Mnuf3JLrLfnADqup5Sc?=
 =?us-ascii?Q?ZaxwpHJhWNwWAh59KArIQUug+5pL0MLJubBhVcWHh1v+sPI+GiJTQe+/U0ja?=
 =?us-ascii?Q?0se+0s/lsET+I38IEtjvjivMhFJwMaH6EyXLS4XWuapRPg+Mf9AeqG61Kqrc?=
 =?us-ascii?Q?WCh5PzA9oP9MX9ofGNX8NnFt/tNUSBZ3sE01NHoxeOW5WLeuDBtsrP4B+2wo?=
 =?us-ascii?Q?0MH7zuOJ4d+Nztvxuck5d9M3SZnecaNwYkGUBubVY0qYgNw4pIlpbEjHBaY6?=
 =?us-ascii?Q?khLudh1vyrvoEuvk14h5MvjDcXIORdbpBheWDpdZhtC6e8wRMZgUHzBAWJSa?=
 =?us-ascii?Q?iQKkFu4rVRwEy9lu1fk3VUltpZKmtScYJFWTxZ4q7Yyctc4XEj3aJo6Jrate?=
 =?us-ascii?Q?lW3d57diy1wzVNFP75OV0TtsEaeIrNdNna+TIpeJu+E6iNSqnqJiNqh7qsdO?=
 =?us-ascii?Q?7NzytAXyO3hRgGScstGylG1cKEQ+RYB1Js9qNtJi98v+I1HcMPHsyc9JXoKW?=
 =?us-ascii?Q?sw6O9P6TJNdn5z0mGa8IYoL6PkHRrfhrmk6w07+QC11HxuSR+x5FEML29ki0?=
 =?us-ascii?Q?8GrUkSZbkuQKnmv7sfJlGEhO/VYlb82u9AzCEv6nf9qYp3nqvHqOndNRk9Pl?=
 =?us-ascii?Q?xYQRWtKNNEUzxsYw4b/isHPnbkuOdeMz9C0Xn0toe+hCoSAytxYGV40ZuDWs?=
 =?us-ascii?Q?cfl2hl4ODzYzyMgV6TpC4Am4lJ+9PsPgkScha9D7jspUkCkfWwbHyOydCzP9?=
 =?us-ascii?Q?wjAL+J6riG9BCfJvOXQtDDlrFCQ5tk4AgCSUSmOWvPKWUnr9cTWghVv4ezA7?=
 =?us-ascii?Q?uAnC18QASDvjqRgHfWYdYSkbNTE10uGmkZ7IigdE+EecKiA+JXTO6SMsf+K3?=
 =?us-ascii?Q?MEBWWJVeZBGWPjsCUW4fp9LinW9vqZBEqMEQwceeH1dZe46L4p30/2axoGL2?=
 =?us-ascii?Q?ANg32/Geu8ES28uG76xO/ToVLC5u0oDxqnqsTueTViKMZK/lhmxk8eNQpw3Z?=
 =?us-ascii?Q?oAhM11CFtGJqkRyUyu75ILHbT8bYSbpCssK/diOJmGyzT4DlVKCosHkSYhcn?=
 =?us-ascii?Q?wSqZushithx1Z6YahBRJt+3Lbw/8s3Ad6nK0rgWBlc9bdg+TmkZuhGLmieVO?=
 =?us-ascii?Q?AocmGacj75hijAB0FHMiddCJNtszvUEEHrMlczOE6OYq1x859GfU3Y0VLz90?=
 =?us-ascii?Q?pHl8TqP0yJARJHsMRZYw5RllGVj7Qe32zj6DzP1VKOQLrN67BopGwnkRP2hC?=
 =?us-ascii?Q?IE5xGVzS01zJ1aAOyhjB1CUGjKqer7mVkLRCwjWRI/fPi46gcmwcukvPYv48?=
 =?us-ascii?Q?TAAUpdQigj/QEF8OZZmwjG1SQmBdmoad+918Xjo9dYro5QOoe3C2LIT5aiM2?=
 =?us-ascii?Q?gSY/p1hRwdWC+KW9ZKdQPMoOiIoJyB+Fv9GDeZxnb7xYHakAVXrGE4l9cuQe?=
 =?us-ascii?Q?qbHF2zhn1KSgqwZ1fS+9MBVn74ujS7O9eG0fyPNzO3LlH8BqNGmFa3ESHLgM?=
 =?us-ascii?Q?B7DjA2ywNRzfmJK9m2AKfog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1176097a-241d-4516-8a2b-08d9bfe61f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 16:15:33.6148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z7cSWukYOPD6AYme/Bj6FJDIQ9ddIkhNiRcDYxn7MdRZgp1+vBo/qPua/AjleUuyFfYSvF68rrEJ2MjoBs7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Wednesday, December 15, 2021 23:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran

Fix the message argument.
	0: Allow power down
	1: Disallow power down

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0907da022197..7433a051e795 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1625,7 +1625,7 @@ static int aldebaran_allow_xgmi_power_down(struct smu=
_context *smu, bool en)  {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_GmiPwrDnControl,
-					       en ? 1 : 0,
+					       en ? 0 : 1,
 					       NULL);
 }
=20
--
2.25.1

