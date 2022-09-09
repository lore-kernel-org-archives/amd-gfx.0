Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D01ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 17:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776E710ECBE;
	Fri,  9 Sep 2022 17:06:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD1210ECBE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 17:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6sX4qiTaTIkqF/Q/Hxb/eeyfw3mEr74x9pV55x53U/Hrz3KiIWcqMGU+H1TCmPuqXSQu9ESHPPYSGjacHU8tmECSgXY0EIpbp9WSOamNJtN+2xLsEljOjAui5bKJzrpR49AFN1qhp4B5vXpt/PyQTG6PEnNK1Uv8qS8c92Y9VnFbBBDzWdSv+ufZDS3MUDFw/l+HeHnoO02kD1VdsTOtG+uSTZdao2ajrlSLIzDmbSaU56xIwJ7TzGy3riyRCr8V9cLN822RAnUpAEq4S5ur8QwxAu4wS5p2X7JRxhkWqNw7YUvA3ZBVarPpQ2lf9aqHU7VtGZgXWzRVdroGoimTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krvnxnm/IobdoMqlf/Gb/oFQOa1PuOKRox5MccJJiLQ=;
 b=FA4re0T7RUHXoMBITG0JQdQUTQs/y/MLt1F2bJqx/EnxSwVFJLgrhJryJnFXcDkyefoQClOJByUmU5gLql6j+tW0DexpuZC+QV4O2uhUcpY29sEOPlXDdnEQhUTlm1LpwKVDFSSqR6Pnz06jE+QZgimiNtPPMm/PxUKYFD/fOrMsBi+Ebh8MCroPEZVPhLzCvGvynkHF2URLWoOhQVhyJyQYO3KsuVJAh8aAYINmy43VVeTVY+GrJny2f4p0MOMoi6s/GOmdhmFuXX5AbKWd6F4+y30FR+lOzzJD9imZKw5ZRrb+pSMjcfxg69AJ8/76vy/joRWN76pWwMsSEoHJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krvnxnm/IobdoMqlf/Gb/oFQOa1PuOKRox5MccJJiLQ=;
 b=Ss5zRk6VcTcPmQGhKld+sCDiZD62Tt9vgT2huDq2ho7dY9UAnQW/jPJtLIml5PMuTymDpd4Pq7NU65V2CkKKQIoba4vUK5ZxKN1rpo2eWE2rUkoFZmp0Fhcsdm6aAUlBGCRHRWCT4Qbu6RguyKdCDVc+EdAtqw738D/mcaIux40=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Fri, 9 Sep
 2022 17:06:50 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8c33:62ed:e957:73a1]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8c33:62ed:e957:73a1%6]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 17:06:49 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix hive reference count leak
Thread-Topic: [PATCH] drm/amdgpu: Fix hive reference count leak
Thread-Index: AQHYxGxgQyudQ4o/DUuIkIRZb/8qa63XUCnA
Date: Fri, 9 Sep 2022 17:06:49 +0000
Message-ID: <CH0PR12MB5372AF84257EC52ACF55861EF4439@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220909165135.24645-1-Vignesh.Chander@amd.com>
In-Reply-To: <20220909165135.24645-1-Vignesh.Chander@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8795af1a-94cd-4987-bdc9-dfbf9a095831;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-09T16:52:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA1PR12MB7616:EE_
x-ms-office365-filtering-correlation-id: 19d4a25a-0282-4067-90b8-08da9285af3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Q0JkXjcs9njbnf8JW22DMavy8gfijFrUPlP1GEWuvnWgwbxCYRpitHb1avXWPnjQwILXnZ3lMm5pZyTfl6Fa67RbURxJwsc0bKeKimsarpdQGORACv2UjP3tiY/oPLVVBPGyf3Mn3v5x/HxO1is12Xa12LUNWLPfGnceaBl350ylvOfQ3MbJYeEiMRxnrcWnq8YvRxsfLA+JAbdziKFOxim3s6diL5KYG3mUrXLANR6b5yhSv3wNgZKAqyLfokQOkZllDdy2g/EjqcDHsZ7Xohf+BisFhH23pbs/0raksUn6RiwTB9nEM6NOLNXkN9tI2hfUiG4hHWbrVCabw6dDLu8/A41ERqhDuSb/VERS2pxrsIf6MVjJ/uEhj5mCCo1bmnXGJcLpXxDzUP3fViFON40EURf8HTG8V9pAl8xZ+huHl7eK83cJCbx8S4+WDxPD8/4Y3MSrXfUUybSxy2VmfL7ewYEDQ+6l42nlKbSq7rt77eKkcf/Pe8IgT7pR96l51wQBbxrpI13sfMYMTAYVyGQXAOgydprnPQZjsV1YjzOILL+ZtxdQ+wunZUuj7eR4Do66lvCcp+USglDoaWjDLMI8s/+L15TNpGvXcXtZiAG02ka4BCpHEqXzivqFP6PyeL0PfEZF49MG0sxFrc0AeBvLKVcEgA/dNo09TXMzvvjGeRcCFgIwsxolZoIsodsv6Mz3OJ/o5BUgD5wKsc+6bsxFpQkrtIqYPq1RE4ds2YVETES3YUVQSJpbzUqEDlWTlUpWYHREbALJhoLMB2fSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(9686003)(26005)(186003)(53546011)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(52536014)(7696005)(66476007)(66446008)(6506007)(55016003)(5660300002)(66946007)(66556008)(8936002)(33656002)(8676002)(76116006)(64756008)(478600001)(71200400001)(41300700001)(2906002)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Qkj6WmHz974MijqVVT4II6dr0W5jWiJ/fFeXDi6RSImlyTjXlggtFddo7oM?=
 =?us-ascii?Q?wABdOu5zb3tvNnC2Dns/G26t81i3qsALzRooSP5roPGzURAdHdkDIg31Wo2Z?=
 =?us-ascii?Q?sLDQc4uQLgSmfu2Y5BovbULZpzkiBh/bW/pEfm5R5m5aIzLn7b5asoMWPrvs?=
 =?us-ascii?Q?xhIQ0POxxBby7gRqOs47QCYAJ8T/zZzmIehdykZAZdv2LKj5M4VaQ6pTU5sR?=
 =?us-ascii?Q?nPR9HwziDcTUWF/1fku6Bb3MAi7ydvSm9vIWcFvamAJkoCMQd3X2fg/rhsP5?=
 =?us-ascii?Q?D/3khJwu6G7H9XY8ELA3OfUjjd5Haz0gj0nE+baD6TZFIaHh0HiydJjazjt5?=
 =?us-ascii?Q?xNBeCWXy1UFEiSUYhQsKrPZSk1vmsJtDAZkpxJNffya+VdX3xaMg7Hyf++BE?=
 =?us-ascii?Q?8dnTkMUQi/HGHCyFgxQklRIJA9sbLNGuH9RPs/CZYgzu0YfyAAU9w2L9khwB?=
 =?us-ascii?Q?aMCTNwqd6hDTH1LBTXabua6GZKf+w+2bSUsK1SZzU83IjKd6Mb6/9MD+iy0a?=
 =?us-ascii?Q?0fiKk4jmI+9sHxEa0SqHchHL93CqiIc34+36t4rujYeZ5O0P5vNCit7lr0zU?=
 =?us-ascii?Q?JLf5fIxvROb4o5rPNoI9WUv8hOw5VaC5fNIazSTcVfdlejli5q2oT/N20CEv?=
 =?us-ascii?Q?vMVnHl7f8sPHTisRTAMF1ta3BYtIhmmHbTc2FcIYgz0x3hhYvGz+Xt4DYrOi?=
 =?us-ascii?Q?XnCAR2P9pQZxFh7Hp6BdYim76cLD/SmkEnlmYH9h4hAVnBHSQDR9lXALAySI?=
 =?us-ascii?Q?i6YA8KjvZJlJBBcsjh1DRpKCzpAvGc/7AjEZ8gaiCF1FPDh3lJ2Jmg43EZKz?=
 =?us-ascii?Q?DYGXtDY8vEVqeJp/SsaZ/ELsS2bTN36yDb5MwVo4jNz8BRFGNLyAfjanDpQs?=
 =?us-ascii?Q?PGoc+gfGY5dOEprLUKzSYH/6ZOXuqiGcmnNbUB2dolf8MG2vVhBSgB4emKSg?=
 =?us-ascii?Q?Pl03CKGEHMu4Y5E+44UpZZGxCTDocvdMcDsWdP0+9qPVAIGIoBKMhxXSZVdI?=
 =?us-ascii?Q?y2TrMgNFACq6AIOTdm5uBApaokor7C8kI2X5SDNXfBF1ZbmA2PyC/+f3bQ/U?=
 =?us-ascii?Q?74r1lTMSl0L14Mj3dlx0ohnAsfHhBcYBFaytedPhqIUUSphhumFqHFP2NtcI?=
 =?us-ascii?Q?TxrqH4t/aJSejJAdwlUg7xYnuZfJz5mX9wDVpIaqtxb6zDiiLmWMYav8M9hf?=
 =?us-ascii?Q?54dFUEJWF6CCbrQzagG7mRpOt+jcMDjt9STxqtOm2aqlqaWcQhXKsFiPo6oi?=
 =?us-ascii?Q?aISRn50y0qryL+h7DHubPHkidj+10zEa8ws6vyd4SfrNm6zHntocz9V1UxHl?=
 =?us-ascii?Q?SMbUHBVsizkCKMeHfTJVgNIcbBi1pIHjhYLAQ8aqDzHpjsZNrvdSeHVJDJdQ?=
 =?us-ascii?Q?FjSOdQ0OJQ54SO87XFdyI+fqmSo9LwKAf1UGJXFjyBpJg4E52Y01rwisLs+5?=
 =?us-ascii?Q?+6wNs79oYJ93Zh4JobqdlzgClOwOjrGVJzBgcXzJaUXzB+pgbdmHRfD5dZp7?=
 =?us-ascii?Q?exyMYlmAb4EnBoGaQPXuHe0laHXYQJ5941B/D7Nj5g2UZFu+HkETnigrysFd?=
 =?us-ascii?Q?4/50Q7mdnBd7KIEZYwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d4a25a-0282-4067-90b8-08da9285af3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 17:06:49.4362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaQaVfSzl71gU9lV5KJBRULRiYOIS781V0EsUKZEKz73bc9iTS/TCwMV/OhZbsb0XCf80MxoRQ3rKeEjtRBjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

Looks good to me .

-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Friday, September 9, 2022 12:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chander, Vignesh <Vignesh.Chander@a=
md.com>
Subject: [PATCH] drm/amdgpu: Fix hive reference count leak

both get_xgmi_hive and put_xgmi_hive can be skipped since the reset domain =
is not necessary for VF

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e21804362995..943c9e750575 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2451,9 +2451,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
         */
        if (adev->gmc.xgmi.num_physical_nodes > 1) {
                if (amdgpu_xgmi_add_device(adev) =3D=3D 0) {
-                       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_h=
ive(adev);
-
                        if (!amdgpu_sriov_vf(adev)) {
+                               struct amdgpu_hive_info *hive =3D amdgpu_ge=
t_xgmi_hive(adev);
+
                                if (!hive->reset_domain ||
                                    !amdgpu_reset_get_reset_domain(hive->re=
set_domain)) {
                                        r =3D -ENOENT;
--
2.25.1

