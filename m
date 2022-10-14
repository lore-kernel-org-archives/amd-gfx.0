Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF5FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1530310EA7B;
	Fri, 14 Oct 2022 06:07:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CAC10E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKxkC00bF9/hNX4NgezfJnZum9/ohAIynu3ZvzG2GM9LvKi3KKFro1eB914U2s6JNpanxb/Mzn7DcbtJR0uDZucWuS2MTCYWQ6ymkCf2gsgSeeV4fDWj81jplPsqib63Y8tlnYd3EROrfqcHY825v88M823FLixSz9cvbZR9MblR3mjWJatu5hTYN6lobXgn0ATDuGqOwrdxt2kZJ/c3haLbENbQqRUhX6+/+mWWWH37ebe6bhI7mRplOxXKXlYsLxqxNXdiTsu4tbRtVXUUWhW0tNNf5aCJeXwi1xG8iB/sW5kbzEFIRIycI9s2C/qb2iJwiOxnyt+Q2Itzu+T/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ2TAf8s3r82skK7sTeZsZSUt8iNnHBe4oVTGy4Pu7E=;
 b=jaEV3/jx1mQKq3K/NY3qOMzuEPyBZ6FhcYp3MYz9BKoTcuDbIQUu+n2XUsA0+DFGwjCwzYIi8EKblW2L+X+u93A/gdOe/CEAbpotjNzjj/X71zAr610PykjVOQ89oeHTpyaJGg9KCE3YJPAK53vEkJpZPeie46Ee6IBhC8jwXPmW3U3eupaxryHBM3pMiIFumIv0L8+CqdxJtsQwEp1YnP42D9tYa+NyHG+6c6lmb+nm8x6YLx5MR0oQ3hPK1rEJNFuRC6K/0nO9pmVtI7ZSn/NlxN4xPfhW7w4SggIcbQpCOJj7BJU/SH5P2VF7IlZVoFZZ8hk3FYYpAly80rmzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ2TAf8s3r82skK7sTeZsZSUt8iNnHBe4oVTGy4Pu7E=;
 b=LhsAfmhAVatA4jdS6SvUGbmkuNZHXnPG7m9VzgN+jMTZOJUKqrjicGS0So8ij1FIrKvmSDMKLpjfnun2nvbqVfgWbgL+Pb9OU8sVc2vdAnQUtvYGhzg+WXHVbOpHc1VaVL8dLZVpg+h18dzMVRgPSVC33iRv7CCw0swWO5gWI6w=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:07:31 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:07:31 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/pm: remove the pptable id override on smu_v13_0_10
Thread-Topic: [PATCH 2/8] drm/amd/pm: remove the pptable id override on
 smu_v13_0_10
Thread-Index: AQHY35GsF0oXDVNRDUudYS2JpOPk664NZbCw
Date: Fri, 14 Oct 2022 06:07:31 +0000
Message-ID: <DM4PR12MB5181F398231004EEA9CB02EEEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055553.921523-1-Likun.Gao@amd.com>
 <20221014055553.921523-2-Likun.Gao@amd.com>
In-Reply-To: <20221014055553.921523-2-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:07:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eebc6fcc-6d65-4d1e-b2a7-12f3f113f2cc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:07:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1277756c-ed11-49b4-a06f-3c81c7b54907
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: cd314393-3601-413b-26a3-08daadaa6163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+kqvYGUdZ1XiSkFZTlg4Wk8Tn6b4bA9PURROcJqBlLNIr5Xrffavwy/ymOSVNEzWisHklDSMbQMcjfu0LZw1x4vEtQHronQrt1FmMNK5FHFazBXljN6XlPHcG4VWN7iePM0wgzstJ0vvpnXJzRX5dz6B5ds6tPX5CoStiPUv9wT3rLzqK/ZKAGUBm21be9P4nsaPfAIKa27c1vfXIMU/RafCHZP0gG8x/UbbA4PkUqLKFqJFBvVvfCunKAtEWrP0DAnmtuRFj2q35rjqbALm1rDHl2pXRQn7nLK4R3kTgQMituWKzbjuEU6y3/14RBr+vD+DhpC25BS09qtMSS6JOeolhMDaxbpan6aMV5nxGvqm4cPrzqZzrGUb83I8xrsXSspvCc1PEwVcuCmEG3p4ldfWHJT/nBOYMwahU2FA1n2V3ZW08CJZWoY2oC7/20IRScirGVaXquIJetUS/R3DMTVsmFL6C+mDffqrIqjBoxYdNZqz2Ear478DjQtjBxu2UGS/LvKYrxYJA5X0qEOb4ZukL6qsDVHC6d+J+xtkLjBOojsBmYRXLORZSe2cSA672WNsAPa4iv9cX0zns/VA/Yc0dnRKzbDTl7jhzX/c/ZX74WyJrvjgtEEc1v5pJJVPuyMbw8uMgyfYbCz88Ul4pQG/MBiBbl+24vjKv0u21YCB1EQWOx9Lp1pZcrwNVeUgiob6D1w8ZJlsQNj5dOIOWfUtZi2+eKf4VfGVmTyflNU2YoT13EgtPFq0g6JwXk9mZD1pZgfcMHatmcVVLuGvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(4744005)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sr50PtdV2NXojJNWOb9Yfp2X2q5dxUBQOz267MeYLrzl+zhTPkQLTEQIg9Xu?=
 =?us-ascii?Q?4zVZajVKreUfLe4kbYowmhWuFE5aEONy28bnXs4NqZfjJcmCl1QrkymtG54t?=
 =?us-ascii?Q?sMLV0YxHzd5UqDWva+6pSJjj8oqq2V4Xx2YxQaUAh2ehXmR1XCYkD6YfVH6l?=
 =?us-ascii?Q?DQLIAfiYxPyk5KRNb26gJDd/0HGP6/hCaSx5OBrzeA+PGqdBb6NCNd24dXqo?=
 =?us-ascii?Q?ChC63ImnX/oi0qRoE8JQqkjMRsXsSSgsRTt1RyosBwU7xmZqqh8+cEZkQnPZ?=
 =?us-ascii?Q?Aez3icmDSmFeNC+nTb6zaFRSxWG13JEPoMLPmQTbqtXKaAQdbzfiG2QtYwrE?=
 =?us-ascii?Q?UPzQ0SXJf8KaoVU20CuoexTc1S3ivm0xENjNT9B9breIasgwrQWAHQwzL/X+?=
 =?us-ascii?Q?taBgwxm/18WpbHEMVcsUy4KRJ/L/3J6fhlU3dOMVM7VvKPBHHaPBjeV1+JAT?=
 =?us-ascii?Q?kBjbu9qYf2y/WWQ5GGeB37BH7klyjR35a3c/Jyz89qdY9R4kXA0o79+SKr+I?=
 =?us-ascii?Q?8SAeU49yXfT2VTWmNGl93POWWOKKax6gFs7FQrbeCC2GG26cXU7+cwWuHQGk?=
 =?us-ascii?Q?al0vg09cbysT/Qjzn2F1fX87VCs+Ozg3RAjS2mrDLq0R1TW8X+lpU3eQysCM?=
 =?us-ascii?Q?iuGVUhYDF/PWsCNTBfw+0tuY2WBbLCqEqPPFYXpQksFTmAJ1mCJpOODYx+mN?=
 =?us-ascii?Q?yHBWAtlllzL7+pksiPnt65sCuhWY0MBjUDBLBsugAwz4C/oEzh2S0iyRo+on?=
 =?us-ascii?Q?zs+78xF3jGhJ6TDTvyYD1woI7c01hevD+PAYcifONefdcuMEi0And27Wk1PH?=
 =?us-ascii?Q?1Cqv6EIrMIh8zDLae+TfLpNfrp7EsmTriq0EWgTES7oPZIAQ7P36j4GMMdSw?=
 =?us-ascii?Q?YFycBh4mTRn84niy185892I8TU10zTkjFHsNNSiOO7IC47sWzROpGDPh64DF?=
 =?us-ascii?Q?u/vnC2ZNRqnFe6e/dp3FChO2rbnHs1J8xZaYx/kLnij5P2l1yvd86phpVm1b?=
 =?us-ascii?Q?EPfJ3bYYYR1Ezf3rsNUQss9tlzS+M0sWwZT7XGm4cR2Wt8CdcT754yIHCnW/?=
 =?us-ascii?Q?zRlfiGYE/PNWO+vtnz7R5CL+6kYd4aGUWsJe5pUS+XkjEgEOK7WgKii0wAfO?=
 =?us-ascii?Q?ueehkEcn6Bo1Z9MD53llh5SouEIKwG3GZT8J2yWZpemeE3eCghV3CPN0o1/7?=
 =?us-ascii?Q?Jmjp5euAyizoDicy8UQGgllaXbWrXS/UoecEaXbqRpTbHOY3bs1yMTWt7BM4?=
 =?us-ascii?Q?/GtcS4i7kSa7PG7uZ2woDrqvbereU3gavULToy7UtaCdbv6Vt9yilE3rLnuL?=
 =?us-ascii?Q?sLEcDT1nuvg8vwPFKdvcWa6e58DtSaZ0GFJBdD3maHi9k1rHY4k3yyoQHkQv?=
 =?us-ascii?Q?S5AFFV9QrSF5XItiaw8HtACYRDe64NjUQh8myV5CUfguIW7tsT3w0YfF0Kf3?=
 =?us-ascii?Q?EhQG3cndsSWRlKJpLOkb3EYoTRr4fPks3OiY7iY71/cWZcStefqOwWdlRh7J?=
 =?us-ascii?Q?ZvS9B394vHR2U8ooIeBcpeID2PfiZjCxTQdQQACcTkICn8AxgLDBCC0mRcua?=
 =?us-ascii?Q?RCHT/IZwLT8xBaKTGME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd314393-3601-413b-26a3-08daadaa6163
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:07:31.5655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6C+ajeju8WYTcDEH18Mton3S3+S7hCOEYB3ZxmX5yDuOVwSu135EU2/vXzrwiBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

remove the pptable id override on smu_v13_0_10, and the id is fetched from =
vbios now.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 07b5bb23e52f..f8f75d1a67e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -454,9 +454,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id =3D smu->smu_table.boot_values.pp_table_id;
-
-		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
-			pptable_id =3D 6666;
 	}
=20
 	/* force using vbios pptable in sriov mode */
--
2.25.1
