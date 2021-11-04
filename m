Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EC7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEC1611C9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFEC1611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF026F538;
	Thu,  4 Nov 2021 13:04:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4166F538
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 13:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2cXO4rjAiQeZDDdqaCa6ShzH7RkGuT7KrIWaxyJVcY6e8P7DnypSbv8BjJER9bAxNECmaD6Q5KldZtWCVNtkNzlWz8AZwFoAArA4WAQRYSSr4gUpwNrrPFNkLQjsj6XE28WJy7cI1+s/467J6XUO2VEA6FJFDwhc+re5HC50XhIxBfX5qwl9QK52BOGsp2PHuGYM9SkU93KtRH98U5f3yPxfl35eb/XumXkqOeFTN29supYQURu/K2cqmPC2W4zbe+C2Yn1uzRLni9IRgDmpHpjfHHYCGdFZvCxI1AN/XiiIVALdlWZQfNzgOokfRNQ9J7/9Y+OKmMnl2z480ZYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yO+qjOZNSmP17J7l9rltTYHISTljPSTB3ud/tcAnWU=;
 b=JXD1PFWMcCo6vFe39iT+C4Eo6Kq0lchLWTH8pCcDte7pFATFtLdVCvDGCqgiY0Fipto4we/C5XsufCvPf9vDvY5lV7XAuc6tHVgvedVVfTXqC0ORRLPIjojwoZqgwCYhFke7IBDJO2x7LvtyyrTQXrhAe7S2tzxgXNSwwgWPu6/jbbVw9XjTenIt8fPHCte2cus5YVWbiEiqV4ueZE1VH5pRXyrrz1a8Sm73KkZy7oWS0aapwmX9hlC07BvyF4KNYJR78rg4pBER3o8ZPJCJqCoAoVQSomCnSQX1RQJSwz+XATOvttVGtAikfaeJc3E7cM4cbiRmUJPNU171uSuQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yO+qjOZNSmP17J7l9rltTYHISTljPSTB3ud/tcAnWU=;
 b=ddtbB5rsfF3AsYFgJA91gI4I+U1HcJ3LGQBlc0o9Lu0TYKeeUBQypwQDA01JvNTqztOHrolQOON4Cd0BSg22kvQo+GM4BSJ05R8X/fuy7aDQTBrSwKxFon+MlDp9TxXr3Z3crQi1tqxFNYC3l7r6BQoKLKvc9MSUdSaU5Sw9SgM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 13:04:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4649.019; Thu, 4 Nov 2021
 13:04:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct xgmi ras error count reset
Thread-Topic: [PATCH] drm/amdgpu: correct xgmi ras error count reset
Thread-Index: AQHX0Vp9rzTpUCzlME+UP3HtjNZJQqvzVbSg
Date: Thu, 4 Nov 2021 13:04:39 +0000
Message-ID: <BN9PR12MB525755ECC9512DD9C383F640FC8D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211104090049.27118-1-tao.zhou1@amd.com>
In-Reply-To: <20211104090049.27118-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cfb75a83-8bc0-49cd-9b91-30ebdf1fc33b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-04T13:02:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95b6f5b2-3b16-4855-8a46-08d99f93a8f8
x-ms-traffictypediagnostic: BN9PR12MB5129:
x-microsoft-antispam-prvs: <BN9PR12MB512917530561C2B2446320CAFC8D9@BN9PR12MB5129.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agyyT9ANP1KRrCblTJHILxwCcQc/4HUHEs/j/ZIQCM9UJ4T+uBn0WV5rYLN0mnis/zHVtrxw2KhASTkj4e8APswijZljLpOG9K8ZT2LZjrX9fK7Qwhyh8lcoIdGh4MbUobik46/qy8IrJgzrRC60/QPdj42nI+DeYrvcUl0NOvzaUH+8Bs6AxiJnnjzjru86Y25XnaFp7uBoQgmNqaNZ6HqqDROLfe6nASITvD0S/06fHY5x3+mRRXAdw8kWkA5/SHefCd7zbccPH+7HttAchDYVzAAbVxQnnP8l6Vxk6XGFEjWGpxC7ub8tE26l4emCNRjR1R+85Sc3PV/Q/7WontnP4I/8OCpAV7NQaq9JVAy0rdnXS/lk6AEApu9mldnfuaTg8n8JehRj8aXPj/zGyGZBUuXcsyivHnQRV3es8DC4PJvInDfNBNf7iSDNVsJX/Kr5gE/Ts6DLY7+0eypsgjP/iINmO13lN/539YpCna2Z+uqMfFNPCHP2rhj0hPrhrxA0aPW2WEn84sxjOqKDvt+b+L2oN4FEtYkiWBR41a7ATaFQ2ws81LgZ8nf7Z3sqGxw8viReOLdvcSu5YiidaswiA6N6W/0EfMSGfHeFD/Ar3O/TXKRm3PjxTrQfw9V0/myaK3PoNfiG0TL/RFFgUUINTFbqC/IOPUKane5QExP1EOm4SY7HyaYBdTjRInLwE1d46h1OIHCLbfN9XFLEZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(316002)(122000001)(55016002)(186003)(53546011)(6506007)(2906002)(5660300002)(71200400001)(8936002)(110136005)(8676002)(52536014)(38070700005)(66446008)(26005)(76116006)(7696005)(38100700002)(83380400001)(9686003)(64756008)(66556008)(508600001)(33656002)(66946007)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7t3sxIiQ3Fb3iUFamnWlRbj0cgQKid2uTY08fbetm9g9hTLs1FxqoS1bq9Aa?=
 =?us-ascii?Q?tPe6RzkUBpJAFCum7RShTOEcRpQST6tyVS17gt9h62sxDK98IXTRvByBzeTf?=
 =?us-ascii?Q?h5qui0na6maCDZDedK9XsgzKBHAo0CCcCJoodMLuiklWaGf1F5CTDbY1Zu5m?=
 =?us-ascii?Q?JQxvNf+7l2Yev50zUeSwZD0HQfOwWwMrgoFje7P+eXVvi5SE/4ZaiLxRudP+?=
 =?us-ascii?Q?K/NatHNW2WcoRn03t3Lbefw0+NJuAeUBtJT/1QfCrh4RT2gpgAnHn3lKe0s+?=
 =?us-ascii?Q?auhVWWd57p/l+TGrVlTiNDlJrk1G4cA5ME8ZGIOsuTWdjPoMJ3vPtIJBDrMd?=
 =?us-ascii?Q?y8B0/3/uA91Fzf5P68uGOxIbw08CSfbb73CgpL3qA7qzG+s+dywZu7+KOCkC?=
 =?us-ascii?Q?0nuvFPUW5VCFRBNAitsV12pXYvOFP6y5HVp8XEKTyawP+CAJk9NpZ8HJ8ZtF?=
 =?us-ascii?Q?BrEgMvgM8+EzLiB2EcotV7OK/yRO0kV3yn2lmr4BvMLVP3FPd3J6MueyaFDB?=
 =?us-ascii?Q?FQ6/ROoW54wurwKIYyeG7hpExnGjDWN61aDcbpcXfRM5EJcqN9Jr08Z8awqS?=
 =?us-ascii?Q?QvtlSeJ9Pm3/YcMazUU3BkG4o+KCfbb2lvEWe7IP8osgfAjm9yl/xG5XV/YS?=
 =?us-ascii?Q?yIB362oLMwCb0w5qCxRIDbn05/aYRbgRmbwdcOdZ1ASl354B6uqyvzZmpq5J?=
 =?us-ascii?Q?BJU5vPOVuU5d7vt96Z+xtVNYgfDaF90FoklmzbYRrb0k2c8aYnwAWiYchaAa?=
 =?us-ascii?Q?67j/y6ceTVYpc7ii/oZC2GGD1jDyWw08mra8T+uiIreHx6LEaNR6Sflxw30x?=
 =?us-ascii?Q?ytFsf5jAG7LLrNVIoD9OwW9sORbAeXKW9ykVmKbEBfkme8CtGr3n1DGqLXNO?=
 =?us-ascii?Q?4X7VWkvp5E9LS4c4ehmz9k+l0Gpqegasii9Sa/aCmttjkCW1+HnxJfsbFfrv?=
 =?us-ascii?Q?QGKe0PeJPCTenQT0jWCKJMd2lFptUfR8MO4NsFw+4X2l6c5qvMV2K4efxwUd?=
 =?us-ascii?Q?1iBB5k3aK9ErmYAmAtYMIcpR0oqWNL3LKForJk7CrKt2fKLkwSIhBFTqyT8V?=
 =?us-ascii?Q?qNeu+WapuTzTecXf9wA8vKxQYpGSLdTm9vJlkbg0WYUeymXJYYqPQUgOULyV?=
 =?us-ascii?Q?liTrO7hHPFT14r5I+X0IZxCOS6WZIeLgQiahIeM6q2gieMFbQMfVtJHc7dsS?=
 =?us-ascii?Q?/jibKpz8emHNxeH1abaAChJVrq7FoL8iSgUs6/57VMeY8elSxiQDEQKWky+M?=
 =?us-ascii?Q?9TyJSSn9H6I1GdLUDpYfPpOtdgegIbSPH2QcgqFfz8bEAdJgLkV/Eg9STeIs?=
 =?us-ascii?Q?GysDH9R5oMMF7TUrTn2WZ1sHq/2zJxubAmAgAwN6MRO6wq2Gh3aJmJ5bx23N?=
 =?us-ascii?Q?wRvlsFEJdm5gNBh7JlN6KvGGFu2jnh1rUSQTf3Ei7RENif7F6SYl3BMMq3sE?=
 =?us-ascii?Q?7f0eEucDlT6BK2t9v29EW+8QQKaWlmStGe84T5NnBGbC3qecL5J3eyYE1J51?=
 =?us-ascii?Q?Vf6EKTrPcwmOtHapy0aXl//KnpJwRA4gilQcsL4MlvBPCKeq37nt1oTYVyoV?=
 =?us-ascii?Q?0ZxI82EPmhQz4GlMkrUqdtL4b+WTA/zEMVGs1hFOkKP7noaQLcr/m1cPIOlk?=
 =?us-ascii?Q?j6X1+Jb8c7drOiEStr1oVT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b6f5b2-3b16-4855-8a46-08d99f93a8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 13:04:39.2161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrE4Fk75UCTcpNIEyUFPPjYCBRauyezHWsZQqpYUokBKT3Qx+0EcvepeNpkub3a9Xlj0vNbNEvn1kjhnBpyzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, November 4, 2021 17:01
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: correct xgmi ras error count reset

The error count reset for xgmi3x16 pcs is missed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 978ac927ac11..0fad2bf854ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -806,9 +806,9 @@ static void amdgpu_xgmi_reset_ras_error_count(struct am=
dgpu_device *adev)
                for (i =3D 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_alde=
baran); i++)
                        pcs_clear_status(adev,
                                         xgmi23_pcs_err_status_reg_aldebara=
n[i]);
-               for (i =3D 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_alde=
baran); i++)
+               for (i =3D 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_al=
debaran); i++)
                        pcs_clear_status(adev,
-                                        xgmi23_pcs_err_status_reg_aldebara=
n[i]);
+                                        xgmi3x16_pcs_err_status_reg_aldeba=
ran[i]);
                for (i =3D 0; i < ARRAY_SIZE(walf_pcs_err_status_reg_aldeba=
ran); i++)
                        pcs_clear_status(adev,
                                         walf_pcs_err_status_reg_aldebaran[=
i]);
--
2.17.1

