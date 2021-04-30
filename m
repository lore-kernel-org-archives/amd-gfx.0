Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A65C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 04:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3342E60FD9
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 04:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3342E60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBD86E45E;
	Fri, 30 Apr 2021 04:33:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342E86E45E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 04:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiPHw6GY+FPcJqbaOQOjdD6Mc1djL1WjPPmxeoLue/8W0elSnfGAcRKc9+1K4cxXdNZZi5J6RCj0zME4dRKs91jZ0eC1FVGv9GFk/YcbM/TSwwZKFcGnEb9UEPlrMFvTQKslC4SwEXykJ0vnuejGYjo7fkclpZlJPa52nV7VFaq23LPkCMvINN+tFNNnB3eLfI+jcBD3wWehlt453u/jsPO2nbok84gMHu9IJIru1n4wbBUR/DsTL00uPkpUnaLkpL/2JyqEiuW4TWxd1SZdVsSaUveY6YuGtXcY5eXb6rX78iTSDWoxwpVlqlHfUe7w9fPACbEAq6+fbXjr9L8VVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4yTJy6zoNDA2PgjaIEQtBtPwX0rPN+WE3Q5n+6vZnU=;
 b=NaHF1EbQ21dwem8GRnHxGJbvyL4vTApNld/4c8X7IhHsyAjuZpT/p9CdyxdSQ1LdH+uBzDYSigR0LAoxA+RlMejl+I58ADRYXc1ksx5O7CpkT0U+m7blzsaUsjfXuIHGQ24bISBTf7DkofTMoEwB9HKR95cen/+WaG9PQUA+g9o1Vt0TVYO3C5MlZZO3HPclV3iUoRev3MKXvotS/lMc3N7vLoJrrURHuPoIWIzX4nU+B/ahnrE20a9xiQ8ryio0kPv2g5aSPme/rHU8TFuf/6Fdo2QmdixqZwmQAl04gX5L9TCkNP7H1qFCRTytILNHAyDUzAJ9ZujgZ+QwfJjqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4yTJy6zoNDA2PgjaIEQtBtPwX0rPN+WE3Q5n+6vZnU=;
 b=3xKfWyz8Nb6wBk/KjI7pfMHErctqS1KeQyyLoOCepQnn8p0wNjO/pwlIMwtpHd1DsE6rVrbup7F/YP9h3eW4eCL0aedLNUkxS4nLt6oy7y7KHFGOOyyTcdFqPDzIeHc+2Y0qTKm5kPrtcw0Ip/lQAeAVH4nibcufbPZ5VhgMBhU=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 04:33:37 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 04:33:31 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Rename the flags to eliminate ambiguity v2
Thread-Topic: [PATCH] drm/amdgpu: Rename the flags to eliminate ambiguity v2
Thread-Index: AQHXPMFC6cPMg8qkk0mPe9EQLIvq5arMehKA
Date: Fri, 30 Apr 2021 04:33:31 +0000
Message-ID: <BY5PR12MB41153C6949909908D83BE14D8F5E9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210429063102.23693-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210429063102.23693-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0c4b6e9-53a6-4688-9398-eeff2152ad9a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-30T04:32:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f321a124-4623-4b86-3b1b-08d90b911bce
x-ms-traffictypediagnostic: BYAPR12MB2680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26804ABFED47255BCD3BF24C8F5E9@BYAPR12MB2680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KV+oqyvPQoMJ7TuG9z82rAqMPKWMNOaogh33xyOeKgwMAoBR+VWkoACyFgugrqPb1krhKvqx+6EPdrcGB3daZ08rYPWd3CjjKODnWTa0U3+dCr09Z7atFWM68xo7GFN8//7iO1KpfarF+AQhmNcx8PKmlbfMgF3xNJhr1X/dTxSyIOdSxag1GyfHJl8R0D05zrFlc7rNDiMBvNA/7hR04KcMq9nbOWnA2qL0NaC1Yjklu4usF71atfRvl0AtEzbl2vRa9NdXJFHyXDEgiKF5lQKq8L3r53mYzE/nz2dAaqdfB4ks5KZvsGf4ZVBcyZjYAJmIYmeQOu8cB8Btr1JZYPJDirUwD+9f8o8gTv5dMDZmB07pwFBWzJF7RGB9xpDAIlO7TD8Tq/RChI7LgJjbAS654B5s+hg+VoS2TBiJ4ceH4Rn7VGtF2sAgVHVZtUxZ8+JPNQDSpxV83O3W06KfVuaVBcvcdsaxwQ1T1W0xVB6Vkrj/zmz8MCLl9iCLOqwehr6AwMgRj/YbXOIfP/NRqBV6bwzewEry/9l0MNVudTTxYjXgLsoEWdCVNqZIfKrcGeOkOZVEnggUI6LzwesueaUcoSQ6LocBzCZxo9ShXkNMtMhwhokPDIBPtCvumqEZL3jYEYkJ9Ja5O3/tMLqOhGnsqEY2lpEjVsDFuQ3x8Z6wOyJp15t5vqZFfnWAudYy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(478600001)(64756008)(66446008)(66476007)(66946007)(5660300002)(66556008)(33656002)(122000001)(52536014)(45080400002)(6506007)(38100700002)(2906002)(110136005)(8936002)(76116006)(7696005)(71200400001)(316002)(86362001)(26005)(186003)(55016002)(83380400001)(9686003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mgxSQNlYPa5mWYh+9mcSYkyNm51/l9/9FWF0igBys0ZXL1EPeHEcoZCNFLol?=
 =?us-ascii?Q?asMW0QREdyQSxnliN4szdbTT+9nJAncsyGQAGfc5RvIUVqmWfWBMAphoj5ig?=
 =?us-ascii?Q?/nIdurGEFE59W6pDfa5uCk672vB0dFcucmHHZ4zVAoXGhejGtm2xHaFa3mIB?=
 =?us-ascii?Q?i+Sp+TbhAwSCh540fBw2gcBYzqdLi6cfjr5v0NUGBr6osm/PdOqBJVd1Qlyi?=
 =?us-ascii?Q?K1Sec0S2sIl95FKfW17dPkQuM29sfYnJcyrpXQeHhkTFJp0tMnWOXkd6IZ7M?=
 =?us-ascii?Q?aDXEFX4F61ikISL9u9g0cm7DVacrklsmcKYXPZQsq51D4cFvo49D7ysbF4pn?=
 =?us-ascii?Q?eY/l3RTGgyhbbSeyzq2HeRhJENkbGY8yZF/9lxc5D4+TDyQBoTtLi8pbbGvc?=
 =?us-ascii?Q?ibWGny7wtcJAxjx5h6sE36d3Jc4pknvyZslxTefMiOMEWntBIKWQ+5RqTxqq?=
 =?us-ascii?Q?P8npK2iAT7mVkhXc269fPhW5J4ek9D2kwPwJKKa3Q6QV2qM3Kl+A/HInd072?=
 =?us-ascii?Q?x+xoeMBAWw+vlWRW323KgUqCtyT9R16Vvclla9gpr4Mm4y9bCQYO5GQNPNga?=
 =?us-ascii?Q?TikVuw3EM5EJAu7oqa7JidB5jTnd/q+r81r8gA4nVlLQ1X0sGpS3yDw5jXsH?=
 =?us-ascii?Q?8bVB8a9bbxcNnYVYN286vdNHRBHEu0Ivp6PX7caUHQgJxdkAHjnoHJbzOH8c?=
 =?us-ascii?Q?EqVrqHE+QmR1BlgbiYfoc6TGENCDfHygW6YWHmkC8K5Rl9dSqzie9OCbAv74?=
 =?us-ascii?Q?d+LEcGVQXIfB7juK+asKyafvAHnT+ouQibuBAsNDHlyNns/GSg9wfGC1hQrd?=
 =?us-ascii?Q?rsnfkexeCAs1KHjOtVsYt8VnJJoZdKP+f186T4AlTpwZ3N70xZTFs9kr6O66?=
 =?us-ascii?Q?kVc+psRDxPSW6TrEYVFimGNNYAMkOa/O0NEnV0ObYiKU/Ma0jAsMzBewftfy?=
 =?us-ascii?Q?YhI12uE28On0oUAH5ABrT7/X9m2T4qyQEcVwhEgj/HNpTX6F0SlyxECiYd1Z?=
 =?us-ascii?Q?OKOMLm1asaIJWd6v+AvPCBPuXIClZ4x5MdMqQd2yTK1t5ECKWHcQHaSrKBUS?=
 =?us-ascii?Q?Bf6x1WMgYEHLsZe1V5Wa/o5DFnt5MobrIOOweRtzQbZUZMo9Ra9YTNdf/l2E?=
 =?us-ascii?Q?o3GUtNU2zSII7otACXhqRt8C/8+UC0V9eiRy7bWLiPeUYzxNCkVChD40CLYP?=
 =?us-ascii?Q?HUD+H/ClLr/lcGznBoCfmezsllAj0ySOlG2NUdwo3Krj71vF2wLe/6R6x7CK?=
 =?us-ascii?Q?/UxOHM2H1MvssIeGece8v1On2x9YttFL/yaqd04Rnj3ojqAgmLVCrEoR/4bt?=
 =?us-ascii?Q?u9/KC+22G3WwJ6Bhk+/QVVIk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f321a124-4623-4b86-3b1b-08d90b911bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 04:33:31.2796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZ5pwnLkRF913VbSoG/Nmqo6zhne5QKKz3XoXfH7luvYdajrvcfvPi9Jz3YFlysV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng
>Ju Zhou
>Sent: Thursday, April 29, 2021 2:31 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/amdgpu: Rename the flags to eliminate ambiguity v2
>
>The flags vf_reg_access_* may cause confusion, rename the flags to make it
>more clear.
>
>Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>index 1a8f6d4baab2..befd0b4b7bea 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>@@ -98,9 +98,9 @@ union amd_sriov_msg_feature_flags {
>
> union amd_sriov_reg_access_flags {
> struct {
>-uint32_t vf_reg_access_ih    : 1;
>-uint32_t vf_reg_access_mmhub : 1;
>-uint32_t vf_reg_access_gc    : 1;
>+uint32_t vf_reg_psp_access_ih    : 1;
>+uint32_t vf_reg_rlc_access_mmhub : 1;
>+uint32_t vf_reg_rlc_access_gc    : 1;
> uint32_t reserved            : 29;
> } flags;
> uint32_t all;
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C4c15cf51efce4392
>8ee608d90ad86457%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637552746778898204%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=bN8GQYh%2Ftzs0Lg%2BhzMqRyoIwuyR42T6TLZdXszh3mlw%3D&amp;rese
>rved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
