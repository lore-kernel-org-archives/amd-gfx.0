Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB038C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 04:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4131210FADB;
	Fri, 29 Apr 2022 04:13:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516A110FADB
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 04:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/cIKz6wbo+2vBOnxRASI0S32HR5zv7xu9geXpBCEe+gMkNc98CeOrE1KW4TiS9znJ3zy5JcggXKI/kqVkzzkgd+o258XPRgYfSjRFC0lCcR9cpJZcgRYvpvt98p+2+TR3Kdfnb/A8jcarnhGXMaHj6WDemEkmy8N1lk5AyCqIr2lLYPWLSjz0+X/KH7FVGeGYxD0HrGtF+rqYplZn+Uv1sjdfJsbA7lYCOS/IQuEYwpaynnU7Y3mFWV/JHsJu/8D7Qbyn/Pg25FCz8wGpzYyQINhmeTv781JfjPwKQ4J+I0jRf7JcIXjnX+FYN8+sfyMbscY8OnrGMIiff85KrJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QqDETFBYhRsX5BK1x3Hzp4Kg3CIFjo+LKOfcs+/i6U=;
 b=X0rtz5CwA4i5f2GfRmTpG6/g6r4OwbxLcBqlyY+8wbsELHVHARjtkAFHVJ7+4obPql22kXfjEYDwgFEYAT/6N0j5wrDX7hr58xcpjKY9M7F1UyqBzT/LtSIhIqm4mxeGySjOKaJGgjyCaJg5wd39jG9O5nH/Wr3HCfJMZff0c4/VvLFYRyD16NIcJAxQu7o8Bpy+xB7g/90qFp/lpY6czoUUt0TugZhGYN5LFLh+hRSVI4Yn5RU9S+Y2HHaD15jiWaIEybb+7fQEDOL/+2F58d5ERSpeb5q5e0wgCxifspboziu42F6PK+8IKgxQyJM/EoicVriKY3hZlgtvls8p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QqDETFBYhRsX5BK1x3Hzp4Kg3CIFjo+LKOfcs+/i6U=;
 b=UnqBBsZtXnxLF2xoSYXsCYQdPcheDB7QjZ+BaQwKp/FSkDXP9QapuXJYIlXW78GN5s2006DwYTUCH6kt4AHkSATqazxqMyiCqN1pR9Kw383pBoqTrFnS3ikDsp2wOZKXQKNif7HSHVPFdVn+WPBGgp/dqIVLcPckbmRG4HAmDKs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 04:12:59 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::a8af:bf51:aa00:26dd]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::a8af:bf51:aa00:26dd%6]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 04:12:59 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/smu: Increace dpm level count only for smu v13.0.2
Thread-Topic: [PATCH V2] drm/amd/smu: Increace dpm level count only for smu
 v13.0.2
Thread-Index: AQHYW38Qyclbftgat0qAJMCD0FAmZ60GRy0w
Date: Fri, 29 Apr 2022 04:12:59 +0000
Message-ID: <DM4PR12MB5181241E68E377952ADA70A5EFFC9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220429041008.1834816-1-likun.gao@amd.com>
In-Reply-To: <20220429041008.1834816-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e70562be-8ce6-4fc3-b736-5c26e19ab960;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T04:10:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13f6b622-4366-45f8-bcf6-08da29968bba
x-ms-traffictypediagnostic: BL0PR12MB4708:EE_
x-microsoft-antispam-prvs: <BL0PR12MB470875D84506B2044EC1DC28EFFC9@BL0PR12MB4708.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwHsPBRwq3WienvOXnuOCYmAwA8wMVLRXVxLKlaqqySzzzuTMs6t3pFIA3yBqGqfo3AflkdfbXuIjtAK5SdGe5PYPUUIPoQ9tfGgwQ1GYgiQhCJr4Oi75kES9tum8wGSZuinegVa8BKXdsezxs7a3K84CADYNkiak8/MmYD5rm6R6Ji7YCl90URFi3aOCjbOXdv9/S4EWZL6mdSJJWs+zs/yduNPftaLyyk6YmGWBVUQPJMSbZX2fsdtHfYkQOHJD6zpcSUDvFZcXambwbpjWndcbMnYFv72joe2q2nulDGHzbVl4vDgwYoX6DjBzPZBuuS7h92gdsqkR7G3PuU2pWHDaI+uUOzSiWZWaQqC8nlklh4pTnP0JRpGw1MSd+JRq5XmPwFlgJTIH1vhcvBMRa6wQ1SBKtLjk7CrCKig6u6xcUdRF8jgp9DZpobJTESLECSFgqXEruSssKRtlKkWIr74tS/ePLcJaP3cpO2cnVRwbm4Ww2GQHyz5JpW8l0Q5/aA4kKASvLGOul2tB24JDiVV006e6Na6DatWMtdHL1sumJD8nbyEC4aGHrK+9e8wM2F+mN6Qox+AV60FNZi2Ygm2fxDxFQjSMKmC9ntSj2cT3WBwHqsKqYf5Eu2hyjzYTw5qj2JBTWzzBe8kMhy/mvjOkCBUIio9/swtO9PlMveB/76ykdMfUan3XBHl1sFqcbSLiAjeeMboheUfjymrnR1z19NvJbKLhnMoo+zJNAaiuqADDy/Q3/R0A3U/x9Ix
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6916009)(55016003)(2906002)(5660300002)(316002)(8936002)(83380400001)(52536014)(66556008)(186003)(33656002)(122000001)(66476007)(71200400001)(508600001)(66946007)(6506007)(4326008)(8676002)(64756008)(76116006)(26005)(66446008)(7696005)(9686003)(38100700002)(38070700005)(86362001)(143363002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ag/3MMnH9yybVMMvpVPXh1aLCKJzk2sLPyRz3kdqJyJkivnRKsTs+t0qjSJB?=
 =?us-ascii?Q?hWkZbcEop/vduHYEjY8g9aGqFRFY6Fg66CkDvFHgpG0642koifPF8Yi+UiPV?=
 =?us-ascii?Q?o3gwettUvRs1wWMeX1byO+OisjBVXWvZ4AL6pX7+9ueCG59ZPuWr391uI5A7?=
 =?us-ascii?Q?xnED7wgXlSD8aE2Hn0Q+Rby3jUeqaFvBmi8gbP15mRb0xubAJJ48sausAbt4?=
 =?us-ascii?Q?jKYE1PE4V7U2CHHmZ+YSh8ZmYBZwSXAoFzJfje7m9VeEcJfNC9Ed4tW2Snxk?=
 =?us-ascii?Q?piMDrA3eUrxlqWINVyxLRyjkJDo9DItmkSMNwO7+5ziKSPYwgdzqtQn2ypzx?=
 =?us-ascii?Q?XSpOFYMzhRDLEK17UhOdJ8cVW4uARbBeT65BTCoowcZqBX/xnfsmop9f5XIV?=
 =?us-ascii?Q?I8lQ3FEPg808MN72ETLSIEtSrsrpttwpoRywsbJ/Zyj2jIuuidfSaA+MEeVA?=
 =?us-ascii?Q?LD10FuvV44d0fsbvMI9qud+yjCSHF5yJmY336bgpS+6PcAkRg0nHOpDh2uzl?=
 =?us-ascii?Q?t5Huileq3jfh3btp1YJ6Y54EKtc/M5/TtqbGyqhQRXE+v3WxQPoZlbQcice9?=
 =?us-ascii?Q?uwZwm1zIPzriJnY0T4aKSsDLyXfqIDC3Hdsc4uu8gmh126HLl4iXBC83WNum?=
 =?us-ascii?Q?d+IltNDiU+jQQprlqS3Vj4jRuGfQ8YjGh2/4PpRrl0A8lmRjyO904vbHJYfq?=
 =?us-ascii?Q?oJwQ7mGcu1Wgzww/Ek2v4Q6XDRKZijuRVfd6/5KETv017qPcx/LURDRjhzzK?=
 =?us-ascii?Q?7NjQok3K+hNHT0Em3JPgGCkDRKhnpqIV80rfmYNYO/zyHBzbk6u0veGfMuUW?=
 =?us-ascii?Q?i12opIyk9DzGzjsWtSyiNYXwdsIziCXnURVYFM4TFuv2fjhYhTCVG0NPCz8I?=
 =?us-ascii?Q?OCp3G3Fax3Kllp2+2QkNrFFv85n/fIgEGZCrisWw5RgWLIWr8VKOVTcoBzTI?=
 =?us-ascii?Q?bdUj+xQRZS6awVTlLFj02eP8BV0TI+yzx9d8kxeuxwXdNV3p/XgXhOG1/MXL?=
 =?us-ascii?Q?WWWICbqPbcP3yFZ93ls30e3BJ3nz7dbeGK9bS2jAiyjp0bisCSuIqepDqoJz?=
 =?us-ascii?Q?u7JB989e3lClnAqyhPV9+XNP6W9+13LjQXMRXWwdIqnNTZwFCPRevflc1WeD?=
 =?us-ascii?Q?EZcg2nMCNlLbFHNq/zsc/qAs6KMTHATOmcJ31uZ458j/FCKs8D+jkbkzf2Nn?=
 =?us-ascii?Q?1utAZ6lVgvDZHD9Nq8EQIMDtAOxmFTUGXZWziFe0Nak3I4+RMLCS4gvCXivw?=
 =?us-ascii?Q?0qSfnMrSd4HHTZhXA+ECqlfggeTvnHudSZ8h6LcwIdN+VV3zz16oaZotx2UK?=
 =?us-ascii?Q?54YOuOCaFTSliCRqnvSR16SNSEJvn0TJrvdmqlkBRb2brZa+Q4o0JXHhSUvf?=
 =?us-ascii?Q?AZLnKLDs5XCezRW2indljIMhQlhSO6zaCd1qgbSYU7RkC5eJUTK5ktl2VARr?=
 =?us-ascii?Q?2qhuqicESY7EqCAkOBP8b2b5mtZddmKZdc5niwK9VD1/kGiK6vef378UMihm?=
 =?us-ascii?Q?C3FzSN8cnwkq+vTq8qAvW4Bma1Kj0fL0p8Ih5TgWnK0yPEJeHIPW23/TFP7v?=
 =?us-ascii?Q?HVRYtt//w7zpsPU5ueIm9ZPxEhVi/XJMtTViS0xogIaVETg7/7kRXgeHyMHX?=
 =?us-ascii?Q?DvD9Jqtmm+S6MZN15OA8jtI2mfXRafa1u3cyftedhnnxyejz5RA5fATg1k8u?=
 =?us-ascii?Q?avsMo2bH/NbvOk/lfin0hbdfZjyRY0RiyalcsBCObNUGDnnB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f6b622-4366-45f8-bcf6-08da29968bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 04:12:59.1826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWK50vRjrG3DDnJkaBYkIAZrq6CJi+6iO1YlCzFO7P1cF1x97nf05G6KxfH43kUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Only V13.0.2 on SMU v13 will get 0 based max level from fw and increment by=
 one, other ASIC will not need for this.
V2: replace the asic_type check with ip versioning check.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf09e30bdfe0..e0514ce3ee57 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1750,8 +1750,8 @@ int smu_v13_0_get_dpm_level_count(struct smu_context =
*smu,
        int ret;

        ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value)=
;
-       /* FW returns 0 based max level, increment by one */
-       if (!ret && value)
+       /* SMU v13.0.2 FW returns 0 based max level, increment by one for i=
t */
+       if((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)=
) &&
+(!ret && value))
                ++(*value);

        return ret;
--
2.25.1

