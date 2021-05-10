Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A6C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 02:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECF861155
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 02:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECF861155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A746E09C;
	Mon, 10 May 2021 02:33:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4101E6E09C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 02:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbvlU8kl5nzidJYyLrYzseEHuauHSDArwr0JZqd6Xxm2mB1OgsZRxctXdm9EZmkAKwKodaUY4YpOey1i6n/UmZoLwlyaaqXD/+Na97v4lcyNvh0LbWrbF677ICM6v9cbgg3k+jcPdaROWiB03exA9tKn7o1+YIBW4F0RzfMycBTaAYpPtlUnqltjaPmHbrFCjhaKCRTS9Pfge/4j9rXuWc/yBkesnslDdrn5isQoLpdNqTpRduZ+kpNRLXrsNwjktk2stu6dtFOC9ugQYKCCd1A1Biv+gmhLY+WkbppU+dDBJXSf3WZMpsHzDb0jd8IXCMgHbGFe1FCHmeNdSoqR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X773iAN/+trGg7xUtUZI4QyePbkUm4ysA195+9byJKw=;
 b=Ep+BgnPMYO73vYYd45SXrYvozu1yIC/hkwQr8YnM+z4TH4em151OwvCDkdjAZcV8jX1UiMj2365ESwInOGsTlvt7bk8yvZbxdnMhlzz1E177zRsDSuEamA/AtHNLGfJksWQ+NYfYu2Hmoi+irUBI6QsLqOISPyjY/vArBubP9FxRJ9NiDPIcRJmsNgrj8thQ/iQS3Hc9wv2Ghi1F6aBmZ8/kiincdE/X2LVdCWddr0oRvklfOUoKYQCHJ+ZW8MC7HCUrlXwf3Nign1smdj0BQueKKikhGB+ot6imuP38UiEQxODBJXuM0vuwwiK8+3v50dUPJJea1VWC2JTp7nGTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X773iAN/+trGg7xUtUZI4QyePbkUm4ysA195+9byJKw=;
 b=aca64Y262Qw3h0Q96bZWhWLz7+a3I7v9jVu6c7f4KHCU+KIIGJfETaVzmNZ9t2go4HtVECqRFagXulXg/THGGw3BI9V69C7Zo1KqiLPy9TeAQazZolcogd3uf+PmusU0g4b6jzQ3ecIDWfNkKfCz+FxDs8YEb2dHECz4DmiP9BY=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Mon, 10 May 2021 02:33:03 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::b5bc:c121:c4e9:d4ea]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::b5bc:c121:c4e9:d4ea%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 02:33:03 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Avoid HPD IRQ in GPU reset state
Thread-Topic: [PATCH] drm/amd/display: Avoid HPD IRQ in GPU reset state
Thread-Index: AQHXRURzIXS8oVXLlE6qjOsJPdAMJ6rb/nXw
Date: Mon, 10 May 2021 02:33:02 +0000
Message-ID: <DM5PR12MB4679BE9978989CC1D22A381BEE549@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <20210510023019.647079-1-zhan.liu@amd.com>
In-Reply-To: <20210510023019.647079-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2be25ac6-565b-4d2f-b7e6-50c8e2efca37;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T02:30:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e35b6d-3356-4300-db82-08d9135bef8a
x-ms-traffictypediagnostic: DM6PR12MB3964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39643CB9D38FEF44E57B6EFBEE549@DM6PR12MB3964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iy+cBlDvnwt80XF3jG18A+skcCwq5mQiRZnFdkScWS/8N28Znzy/3iuw5lJdIzxHF4H0uap270O2fD7Taj/5PF8BbsuTkd7GI6Wqtd6Wxdc/ueyMbDKxRHo7l4r+29LfHNRE8I1jcjxjqooSnZQIjJN+PLXqhrjXVs22oEsKVlIaOOzZokqYnImQwD4kh3sVIV6kye76+ShhW+lKNJXrORjBcbkuri9nKYRHXsch3qEHTJZjJ9FvTRz0qQ88RWZeHTxBbHXkgo0VkOP6wysfWjkDglVXpPN0cmUgQHT6iuJ5GbA41WdqKzheyxw2PyKm9f4jPqx4sqPJboaov+zfzUekEyrOennMmv21qb0/pAXRupZI8Bh0fegYYLfZSJ0mTaaESwkGN4lOfeaJXAINWf/8eTRKk1MgudCm0ZS84Q0JAk4uvrWio54SA3DNKM6aclHhdBcesBtosZ5COzy3GbMw6UOZoq7K3dMgB88l501YeimDQcWG+1g8qpUc7R306RpaKbyMRGshnVHiRFBtXFOyNc3O3Yq1it+aRAjYewS4QYozatHsM4taK9k6wkr6XqQJI3HvseFzDXV6z6X/vklAREUDhxRsVjMHnJBweUo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(7696005)(316002)(33656002)(83380400001)(66946007)(186003)(66476007)(38100700002)(55016002)(122000001)(9686003)(5660300002)(66556008)(8676002)(478600001)(71200400001)(110136005)(26005)(64756008)(2906002)(52536014)(86362001)(6506007)(76116006)(8936002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p6zQL8luGDTmn4tZQ4SczBP2PQDANfjKCAN0V1EMJEb6YVz38S3z6xGeRe+K?=
 =?us-ascii?Q?P0o/2fy5xYKhBoDowtMKpfCfuE6bs6NVbN0tKM6zlZBsJPfd+tJa7mzZpFwK?=
 =?us-ascii?Q?4DfOruCUsDvVSwQr2Py8yOenlYoL5YyqHL7eGDuq7Ywoak3YnR9KiW5BfkaH?=
 =?us-ascii?Q?aa2OnvDmqHOXhcs/nbEj00YrAYy76yNoS5jLXkkSN4Az3S4ToVRrEDFS05R4?=
 =?us-ascii?Q?UC1ooFpTdCqX4r4rScjUk235JPjGky7EOgGw5jB8d2Xay81YRVKpSPkRIxCd?=
 =?us-ascii?Q?kPZnJCOysHu65ebKq/WQ4yjA7TRuhPsuvf0t/UUpACI9IElAaaz/Qh6S4Yu8?=
 =?us-ascii?Q?FeY8AtI2visnmWKErolu9qrS8DALbdYpivPl4kSRDvbLPC8rNmwIGxgMj69H?=
 =?us-ascii?Q?aQp+flWX5TraS4Ei8J0nZCrlZOY7Jni0Q6+BTLBu8o/T+uXY0P2qpKpPKL8m?=
 =?us-ascii?Q?C/32AqGT4WUj4aOe3EHY3L8R7NJ0oxT3BmnGthUMSvUIPknkKfctOwX36CTK?=
 =?us-ascii?Q?VUcedAqHTVHOslb2Jn+WjBZEfE2P6W4yJIXzNdtSg1vFgxMLJapm3v30KEm8?=
 =?us-ascii?Q?zEuzQlYvEAqjl2bUqbix5vjEv8jNJhrfULByVna3c1jCcEKWykvYBzJl/0af?=
 =?us-ascii?Q?HjZVA9P0spj+ds3yzy2Zg6u+1K3syyeIMeD+fIcNWvEPJoAuSzuYs1j2lzAW?=
 =?us-ascii?Q?SLTyjVsF7HSNdfypBpSBRKhs5mfOMHbk2+VoY3HdzsbGjzBrH0uc1auDk+uS?=
 =?us-ascii?Q?aC6uqj6q1+WxZyv4e7BvutvjJRMbbhG5bGsn/OjAJYaS56vozs2pFn3d2BSL?=
 =?us-ascii?Q?QD89cIDG3fhUeqBcbbd1rBhvtTLf3QYVZnRpsvyiKqD17M8quZd5EfGArLc2?=
 =?us-ascii?Q?rauixT1BNtvOLG72jnGXfVvCg8LW7fEBYwgAXlOmNhLPf/l1TLn4db++h6A/?=
 =?us-ascii?Q?ew7qcvXBug2kAntrss2yVIZMm3aIlDdIHoUMY6sbfqDh87PALVZPudWmO+Hn?=
 =?us-ascii?Q?3HUDNH6LBfk0+793ukVQNawSRWsY0G+gA47SMxSdSYEvCfrKz3kGXEnWRT9P?=
 =?us-ascii?Q?0V//Wy39lcLmhMMVMusGxv77s76wwww4/DGp0LbbN5psDem64IvVt4FGoVR2?=
 =?us-ascii?Q?KpspC9WXjZP5xss5pawuTMJx4VZigsseAMbEAaM5iBuswcI7pUh81TXdHmxd?=
 =?us-ascii?Q?+nxuAkulWtjACFbymxjJWSjsX/ivZ+oA2AeTAgnrFljo1EH0R8JyjdldL+ky?=
 =?us-ascii?Q?Y8DaVoXEbXs/H0mWQhv4+ukKLKVwsU3mwLrJNOxAmuX29+FD76kYAh5p5FDQ?=
 =?us-ascii?Q?gP4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e35b6d-3356-4300-db82-08d9135bef8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 02:33:02.9283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohWsSE7rtFuD7Guv1Ho9e+9qfWpyoYdbr8oB0JialvMxqpIv8guRMl5EQZGSSPygwQ3tvyIs4/2biaXxecxCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>
>-----Original Message-----
>From: Liu, Zhan <Zhan.Liu@amd.com>
>Sent: Sunday, May 9, 2021 10:30 PM
>To: amd-gfx@lists.freedesktop.org; Liu, Zhan <Zhan.Liu@amd.com>; Cornij, Nikola <Nikola.Cornij@amd.com>
>Subject: [PATCH] drm/amd/display: Avoid HPD IRQ in GPU reset state
>
>[Why]
>If GPU is in reset state, force enabling link will cause unexpected behaviour.
>
>[How]
>Avoid handling HPD IRQ when GPU is in reset state.
>
>Signed-off-by: Zhan Liu <zhan.liu@amd.com>
>Change-Id: I29d80501e44096068e98b5d5984e63822dfcef82
>---
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>index cc048c348a92..58b59152a8be 100644
>--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>@@ -2769,15 +2769,15 @@ static void handle_hpd_rx_irq(void *param)
>               }
>       }
>
>-      if (!amdgpu_in_reset(adev))
>+      if (!amdgpu_in_reset(adev)) {
>               mutex_lock(&adev->dm.dc_lock);
> #ifdef CONFIG_DRM_AMD_DC_HDCP
>       result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);  #else
>       result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);  #endif
>-      if (!amdgpu_in_reset(adev))
>               mutex_unlock(&adev->dm.dc_lock);
>+      }
>
> out:
>       if (result && !is_mst_root_connector) {
>--
>2.25.1
>
>

Reviewed-by: Nikola Cornij <nikola.cornij@amd.com>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
