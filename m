Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81421C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 17:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395A761C17
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395A761C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1A86E158;
	Wed,  7 Jul 2021 17:13:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970486E154
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 17:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyBofJ2E8ZDVQ16SxRV5YgXUPvFdplH9JleDR8qux4x4Ic39MBGyqKYB5V9/imUeKOrGVWOO66uO/5aU5YXxhZAnC+sKosW+RXgse21TODlTYlytH/NBCD4AOExEenMd1zqEqsQcc0eyDfJH6NI4DlYklcTOONtBvHxXE5SjVWaxiCgWuvzrVdfsHOA1tB5txmwnnR84Iszsl+59mVGnayAG8T7eyGCqzsIkmloYQz2sC718fciFjj1NnCpl9b3kR8U0WT8kFYRdSXtysE3u7PtWWofweJZTQj3BaX5e3A/k0hmTLHnxuVRQEhma9mwUklcQvtAmN9Tg7f2lbxo3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxxNIsSpmedlnRiq4dWjzfs0GVlim94ljd1KvQfrwGc=;
 b=Tzv/mvPfAFQR/L9t0tvKk6Yif9fMxwQGj6KR1irZ09pvy0xbq3+tM4WE/j7we57C5U3FIkybS88ZHxakOOjVHYk1V6tsTuFY2mBsJ9oq56qPBiIwl8dO0N5dT8xLEX8Syi8wXMHWEcWgguBsDd8eVu04S1ynSUa2dY3MJzuFKwgCP2aRVvQdR58tYKr55QOS3jYrlHvA4H1fHLHELfZw9E1W/ignfYC61lpsdC6/FQ+jjfZm3jprnW20OxVWcR9Ox9YoNs9Gt91KxvMtWcPoY0zRwsEnyRZv9/tsr4W1WDDGR4P2SL4zpJch+3+Qaj6+8S2eXHWAzRwKh0J2XPRcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxxNIsSpmedlnRiq4dWjzfs0GVlim94ljd1KvQfrwGc=;
 b=sczzHW8pGkJOH1z5fDTZpHqvpVcIQZO61W1VdkDSfWPVpch+jba/+3jldR3m4aiYCl/srQVJDKazLeIQGG/PNrDXdxgvDTtsM3onzggfU2wkJ7gpMgr5rsKSDHKvDkGQ4hNtpX94jUsltrnXS8J21MZbUfN5TDDXY+0DQlPkoYc=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB2924.namprd12.prod.outlook.com (2603:10b6:5:183::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 17:13:04 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::3000:95a9:504:c980]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::3000:95a9:504:c980%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 17:13:04 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Disallow debugfs to hang hws when GPU is
 resetting
Thread-Topic: [PATCH] drm/amdkfd: Disallow debugfs to hang hws when GPU is
 resetting
Thread-Index: AQHXc002yd4gRjfNXk2OhmR81plNKas3v8Jw
Date: Wed, 7 Jul 2021 17:13:03 +0000
Message-ID: <DM6PR12MB33249D5C0B55027E48621186851A9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <1625675287-8484-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1625675287-8484-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-07T17:13:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6cba6d35-7fcc-4c4a-b560-d1efedb23ee3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01ec094d-6e3e-4e00-86d4-08d9416a7b4a
x-ms-traffictypediagnostic: DM6PR12MB2924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2924FF95605DA0DA12B513ED851A9@DM6PR12MB2924.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2tUb281jrkyFWV+JK42jYuflktIS4m/EYyD/nTQERks0qECfT6uKPpOADlsi+oqbs5IlIAV9XG8CASfDFDP8hiNScGu2atJljzCfEzQLYHjo96aGZAw9R4jqYqigu19yYLMAbNjJeuAAEWtBkkV9NRWFlL4dlClup/RjBtxqL406hgJ5igxkGiD2gnFvy32jFlQNLTw51qSQBY02DfBdcPTZjZf3KGpFoMk+tMofQgzeycQD2NW8N7siuBpIRccR97RM3/HmqVJdfdyOkEhnpwzGp+pLHuJPuGw5w2Uk2quQfKdNKd7wIxzxubMI9JvnG1KJZEEnvDxfBQVbQkUYEpJ4eY4+KyRdQX+mig8Tzv1UzHUr9/bxWGxA/Zuicf8rz/obc50KIaiIgiqTpGwkoVARvW5W77565P4AV0roVikxMZl126XOR1J+zyEflY0yJiCB4AhF8nQpQMee46SeXq30wFJCBhnVPYUVQjndb8R1ENOuEcHxhXn7XEAGaUz9Io0cg/7XIczhDl6w5Ve/KmoNsiOUmze5XbbmkrXVthUwJVO022hKDODyguLKlIjDCOYf0zdthvie5QoIekA5ShECZKdfd5M/Qs8GUF+aAv11TBBifZQUG/1jHCN21DgEQ87O5B2UMbg5DuGDnRePMVmTgrhcu5ZL1LSJxD6aVx5lQZGKQq5ZDpppSEDuNU1/dgBDM3JLican0TxnJ1BuAbBOeHLZT4qYbBMvXwyoOc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(8676002)(52536014)(2906002)(83380400001)(110136005)(6506007)(54906003)(71200400001)(7696005)(8936002)(966005)(5660300002)(186003)(26005)(33656002)(53546011)(9686003)(55016002)(64756008)(478600001)(66946007)(4326008)(66556008)(45080400002)(66476007)(316002)(122000001)(76116006)(86362001)(38100700002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IF4HkF7dwHkax9dZ5eiSrnIs7Ls5N6wq7eRsglymd/HmjikJhooKz0pSp+em?=
 =?us-ascii?Q?JUJMsVIeL9/h48iQGS54oK+Np0BW33bmmd5qs96Y2RzJkK3ntOIStf0p5Vaj?=
 =?us-ascii?Q?N6/5dkgFXA3bxCDZtuj7OH6HTbVB0vJIZTsB750dp0kTNKJHWCKHTvTbTZPx?=
 =?us-ascii?Q?+PRdMRkzINIjbC7x95sI3ZKfOuWtoRf5JlNnSLNXhVOiDAyku2YY8rDvzdE4?=
 =?us-ascii?Q?fQwVxcoBAXPs2IIXv1tBwt9vUyRybVbPg+blT1vhcY8kxY+UfJ9ShuluDYfR?=
 =?us-ascii?Q?ak6VytY2+ZOdRWyOZeuuOQy248CIGYkWyIoajWYQ8gpelTu1KpltiiYW3sbC?=
 =?us-ascii?Q?ew05PUGw6KhJm8R24o+wO2O/1fHS9I80LIIbyjQGqv3VCmeXh7KLQIr21WQ3?=
 =?us-ascii?Q?WB+omL7huIOOtQwRvlYdINHXDT3/Tu9VeymYqHb0UcEfGTJC50W9fIQBZNP3?=
 =?us-ascii?Q?TEEpmS27qd1auPdqOqSechfd8UQmiDO1M91qc3zXTGwVgqMTHXA2V20aQbho?=
 =?us-ascii?Q?g5Jxy5k+HPQixItu+DW3aSqB1CKIJ/RiXma3ahbLRrDwsaMcSWFkSS/DV+uh?=
 =?us-ascii?Q?nB58SE0YL9ptQNLmxKu6AxvKyDzE8z8kixYZ/KoycVLuyRjt5648fbmJR0qk?=
 =?us-ascii?Q?651RnMVzAT6gL5+7BNzzl7uNz2YMEhRmZy8L27fgOOvfRNd6N/5uvkxYT6C/?=
 =?us-ascii?Q?8BDWMS9+z953U4P9h9tg82IcwqxOonuCe4Z4kt+uuyD9n8N4MsY+cGoqqmd4?=
 =?us-ascii?Q?Kytff6ZI3QZoDnVTrX68vAxdegFOMCwshdg5x1LYUSLfIPZBlMdlLDihSLsZ?=
 =?us-ascii?Q?rhs5EVxGhAn6PPDiW63eoV9bm6L3jazKYxc+LmYpY0EMthNSgyvW5Ll1XNLw?=
 =?us-ascii?Q?abPm6EEPNpduazNTWT/OWeTP8R6O2YLJk8hxESERpmGask4jxPIJfnOj9xWu?=
 =?us-ascii?Q?1co2YO+qbo1fJpGwWnU8pSfkO+J8NVO47hnMBQcCFW8OHSFaIzcPjfKlMxvy?=
 =?us-ascii?Q?K1Suv7Fc9k7jkgs9PDBrKib2PHSDEAVLt5hmhwE11oc9hsEu7IhqSXCtTYnS?=
 =?us-ascii?Q?gfOj/t1rcBjiiNHaLsoZkZMArBNLcymBhNZPHBk+zSSKXDsf5sZUS0qbdLSo?=
 =?us-ascii?Q?0EA1DVjsfhEZfms3f2pdNq/0FQjyckNrxqzadhiO6ET5QyRHUX4FW9jmjuEp?=
 =?us-ascii?Q?lgyarSSGixGIWSXpfDLNtOeZpmuZsmlxAkT3uL56HsTcuMRTGE7fJw7VIjNm?=
 =?us-ascii?Q?J3WGqG/EsBn+5IowcqD7PkyzQcVVRbmOq1UwfUKUel7X616rlwY3Vm4psklA?=
 =?us-ascii?Q?/MYNH0kyrbhzFm471w/m3Ic2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec094d-6e3e-4e00-86d4-08d9416a7b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 17:13:03.8587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEs7QeFL6KAHPMtcxURFCH5mCzHSxijsArjSokFHFzTaiMkhivQ9F61E21Q79jVB2qfRvD4FhgIYjaT3oiKD/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2924
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
Cc: "Bai, Zoy \(zoybai\)" <Zoy.Bai@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Some slight grammar 

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Oak Zeng
> Sent: Wednesday, July 7, 2021 12:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Bai, Zoy (zoybai) <Zoy.Bai@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zeng, Oak
> <Oak.Zeng@amd.com>
> Subject: [PATCH] drm/amdkfd: Disallow debugfs to hang hws when GPU is resetting
> 
> If GPU is during a resetting cycle, writing to GPU can cause
> unpredictable protection fault. Disallow using kfd debugfs
> hang_hws to hang hws if GPU is resetting.
> 
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9e4a05e..c380be9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1390,6 +1390,11 @@ int kfd_debugfs_hang_hws(struct kfd_dev *dev)
>  		return -EINVAL;
>  	}
> 
> +	if (dev->dqm->is_resetting) {
> +		pr_err("HWS is already under resetting, please wait the current reset to
> finish\n");

pr_err("HWS is already resetting, please wait for the current reset to finish\n");

> +		return -EBUSY;
> +	}
> +
>  	r = pm_debugfs_hang_hws(&dev->dqm->packets);
>  	if (!r)
>  		r = dqm_debugfs_execute_queues(dev->dqm);
> --
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Cc5c011d6af3c424ef09708d941643
> c61%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612721494784138%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000&amp;sdata=FnD7q%2BKiU82DCSQqMvgA8D6f%2FPS6hnQIBE7Q8tCh
> h7g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
