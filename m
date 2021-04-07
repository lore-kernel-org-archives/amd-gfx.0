Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FDC43460
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961EA61246
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961EA61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF4C89A9F;
	Wed,  7 Apr 2021 08:31:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802D289A9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 08:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhaqkNqDosni7vQZzPQAp7EvZ1Hl89glO2uoBzQsNbgoCYRQ450cRrtFsyJ4FyE5fHcROO+i0wod7VfTEI4UAp+y2p4AKNsv1Vv7kDRqHbk8rFMLgh+1bgahWVA/WDkbAoc7Ql3avZDkT1JBhZm8+F+eKGSAFkAUzs5E2A3dCDj30OqqjtGoe/bfPCiaDIy4JAMCm2iD645PRD7cD9aWzcCviBARgKg+0QIKwr+JD6jIBFC51Mg+0FRJSbeYozCv8pYh8lNlLNdOVlpzv8dxEKQZPnXJwfNeexGmFvONo0C7PVyGrk1gt0+39Vry/6m2zMWvdJKdhD7jQPO4T/d8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYcYD0QvwhHEcpCC56qHSmlVEF/J6Mjky+jEVdnIPd8=;
 b=T8lKOs4RrNpqPJPOeeeHAQCgFv/Xgy4Bp4d9mGY2UsH19a3Vh/27F27DS6cP8YQxrvGjbSKkX7CMKvbvnxEthRgZNMQrpHhNjpGGGFq5CTXS4vY9Gm4aWpuW2uoi4UVXrr8axdbepwh9D7R5csYQFa/9TNZq6HArJnnVQykzlOJ0tPHowy/HSpmTCiwfXJT3phx6TgnPNSxLy/ErxRrNA3Vv74KaJ62wL46OBBl2fhcv0h2wu/y2m90353sp4uiKYbeYldW473Qm1bgiKAqc+SgEQkw/K4IHHDjMyxjQ+B2RS5JF/iOUxwLe5/E3doZVgaPkj5hFQI1PnZ/CWd23Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYcYD0QvwhHEcpCC56qHSmlVEF/J6Mjky+jEVdnIPd8=;
 b=ZbV584MLhbFqAQ7H2EFCLMcercZLOpsSNQp9OvKHDlwZmD4HAcvwjffNSnpSpBItbpqePd7UjAHb/JhKe4bwgwBHVp+e5YU5R0R6oQ6gtTJznk6BOucs2MQzcLADjm/IqfgXfi4TrBxNaJMwuj9DJutkZVyAZUi+eNTGZ+024LM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1834.namprd12.prod.outlook.com (2603:10b6:3:10a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Wed, 7 Apr 2021 08:31:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 08:31:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add the callback to get vbios bootup values
 for vangogh
Thread-Topic: [PATCH] drm/amd/pm: add the callback to get vbios bootup values
 for vangogh
Thread-Index: AQHXK4etl5BMDEf3N0aJxFZqTAqu36qouZng
Date: Wed, 7 Apr 2021 08:31:28 +0000
Message-ID: <DM6PR12MB26197A39DB871F9D5CA168A8E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210407082551.3773040-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210407082551.3773040-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-07T08:31:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=68f73de5-139d-48be-9509-ec5c07ea6443;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d3ccb0-5b6b-4dbf-9f0e-08d8f99f8a68
x-ms-traffictypediagnostic: DM5PR12MB1834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1834420ECC346E3E551BFCFCE4759@DM5PR12MB1834.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FTigFmqdu3qBxmfbbvrhApAEKASAgxb2n9Z/J2rB+YVVoxKHac0k5rHs+HZ8R+kHXxNRBUzGntmBQS61h4+TCJVzacvxXpJ6SN2hwLBl2ynMdUcXlk1Os2aln7vPQ/74lE2MyDAIsl9lT8DbJfRL9NQc2ZLPzAmsmp/XwD72AqNXOo3i+UJnb9OpHyRJ8+Rtv/RPNEk2jKlom/qsihwO98+rgodCPjcHNpJUUGvLiyIRJ45ywM5wbfh49/LlbXF6rX4OB/OFstp/1od6utjRmv8X9HYf5aA7soqjyLgUAMK56NlgjDbHbW1Y/aXpHoeHrimElLP7k2pzAYmV5QyydOMkCAaT0RTIdQ5GcFOQynPb4XISifrNbI62oeu3sYfdtefNkCBFY9Y+eP4pNM1LShVCQgcvaoO/dsYRUQxT/rE9+k4jfWb5Xbnk1u/SuI9c6+tH/Rnd31VR8m4eVQnLt2aiTvKPtEgz0yhWncGxp/JQHotIhS2eDZ3Vzh+6fyIhJdu1aEnmtZt3nIKqy4YllUlSDlFyux/K4QZOyxfMYVx+c6rKRs+0FvCnlOEf084H5hvVPVpMDkEcW+OTKS1MKe5FIhWHxJSDkrSSK3CzWAAtsEMijnsHPfRq4KbQ4YeYFQBIVGo876kFS/38haLv5vL2vsEqYRSdduKcHs2Q4zU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8676002)(5660300002)(52536014)(6506007)(53546011)(7696005)(76116006)(478600001)(66476007)(71200400001)(66946007)(9686003)(26005)(2906002)(66446008)(66556008)(64756008)(38100700001)(186003)(83380400001)(4326008)(55016002)(33656002)(110136005)(316002)(54906003)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2qM/3nURZZmJoUKC2zCzm4klVxbdc5Wvhqhq+rUwuwJhEBJ1h00ZoKRyFtJ8?=
 =?us-ascii?Q?Fk6W7FWjpGqIvjSH1i49056glc1RsINNhjccyyTzOZzplMJD/hNekoiRX4n1?=
 =?us-ascii?Q?ShVvoNcS19GVG2unIjJHRs3Nl0iN5Q+poKOdvRndGuqPvqrLPN8zitbTq+nH?=
 =?us-ascii?Q?Vzay9ZAe9YyJC3wcTYg1g8GJA6rMGWKp+s5NDh1opWOhDUNrRihUIIBqNDe4?=
 =?us-ascii?Q?yKGvWcH1Jj1BBFrWIJy/geu/985FrumY7jQYKbvFvB8aLUpijpo+LKlabSp/?=
 =?us-ascii?Q?GCb/YxdpYvuqcUsCUR8rNVeoiwsAVpTFpHiv5JGaE0VZ2FoTjgKUAdf8J6/+?=
 =?us-ascii?Q?swGIdztiA6XmsGwU9g4gTBnAMsNI14V7kozGc8VIXtLLIAO00elX/Jsqi2ZQ?=
 =?us-ascii?Q?qq3SqKuIGgNl20Fci+3aIXnd1Csh+zEh93dAX855kyGnHNPKe6Izit+C+i3P?=
 =?us-ascii?Q?y98s3iQxSJ9HTReqhLCrOaHYV6LECjCNbbq6wPeIdB6RDQ9UNZAd+XNPBnle?=
 =?us-ascii?Q?UyZK7ow/zVVjOC9jHzd6r05OMncuLBYVaL6OAOkrELJrIbJP2RJ+qtvJkvqb?=
 =?us-ascii?Q?JUYy0f70rCOYb3GECodzQrbh01rsR0pR1KvpR1cOwvH2P7bCm1tpHXSblToP?=
 =?us-ascii?Q?xAUJba9I5bFVCVJuGJ8CSxMoNMSelE/vA+zOCeGkYf9CZccB5COPkEilrVJS?=
 =?us-ascii?Q?6wZnLtkNMdqrovcvldeAjWpji0S3YwKZMv0nI8Yw7gGrM8Dw+C+EaMwXU/kX?=
 =?us-ascii?Q?k1rHct/QgPdTpSo8jXFR+FQps5ZIJm0AtL1rdv+qVSobxNc52kqCK1g67WOS?=
 =?us-ascii?Q?4bSFPSsEGIKv92Txoozgrv1LA4Dhd7jWqT+LMVoWHM3JYi/06Z5zv4vBTWUj?=
 =?us-ascii?Q?z1W2kfL2QU64JNHRxSTKZwqb4L9dgxq0pTGyEi4dvaEXDZqe88CsBmocY4su?=
 =?us-ascii?Q?cW2AJFuH640garaqgnBcAuC2Q/UNGYrq17Oil6cRWqBU7DMeHQi5jK66E8YS?=
 =?us-ascii?Q?9aNf7cxoIurHmxOy8l00zoNQG4ErrTlgtxW2uPWprstST3+ug4dqLC1qNTMz?=
 =?us-ascii?Q?/IAoGe+aHZYhgCncrMs4f3u2jJpaRCIbJI1sGczJd3+rKdpX5L9jDNcayMsq?=
 =?us-ascii?Q?fQGT+z3Lkep3fCN+iEGNfMo1LUORMdB2o0bBdEBf7s6QHcihmQtdnAQLFGgE?=
 =?us-ascii?Q?tL+vd7OVTjgVZPbAGIkS20kcno0bqA2W8zL1rpFHe1pCNYcxKvqwIjIef+R7?=
 =?us-ascii?Q?8WjgDDSHGAJyKvJ4ldmazbwm9UXO/ZATyjsOngovYMXyZ3zvBgvpy+vq2gAw?=
 =?us-ascii?Q?d8cyvLgesUcfzqMBO39rMeRE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d3ccb0-5b6b-4dbf-9f0e-08d8f99f8a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 08:31:28.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+84gM/ztI47pf1MYqzd2KbfKzNlEHMsCdqyPL8qQm8/vNXgwweyfMaAv7eB+rEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Du, Xiaojian <Xiaojian.Du@amd.com>
> Sent: Wednesday, April 7, 2021 4:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>
> Subject: [PATCH] drm/amd/pm: add the callback to get vbios bootup values
> for vangogh
> 
> This patch is to add the callback to get vbios bootup values for
> vangogh, it will get the bootup values of gfxclk, mclk, socclk and so
> on.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c   | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0d137af1a78a..6274cae4a065 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -561,6 +561,7 @@ int smu_v11_0_get_vbios_bootup_values(struct
> smu_context *smu)
>  		smu->smu_table.boot_values.firmware_caps = v_3_1-
> >firmware_capability;
>  		break;
>  	case 3:
> +	case 4:
>  	default:
>  		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
>  		smu->smu_table.boot_values.revision = v_3_3-
> >firmware_revision;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 5aea67637bd8..7bcd35840bf2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1894,6 +1894,7 @@ static const struct pptable_funcs
> vangogh_ppt_funcs = {
>  	.get_ppt_limit = vangogh_get_ppt_limit,
>  	.get_power_limit = vangogh_get_power_limit,
>  	.set_power_limit = vangogh_set_power_limit,
> +	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
>  };
> 
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
