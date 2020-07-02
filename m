Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 11:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911B5208D5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 11:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MoDP4eW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911B5208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5051A6EACB;
	Thu,  2 Jul 2020 11:45:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B9F6EACB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 11:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFipIarHYkKBiAlkjKYnI1f9/Gmt/SIuTbo5u9qeS1IDI+x2BPjt47Sdi2+EswgrkiBpbXdqwPV4zb8PZ+kmoAgG4NFdsNZsYjSblrzuNqskYvSczTjqOK1Laizh3rDp1iGgKHGNLJq3Th4xb4BDaZHn4jHnGH4gmtDxCugYsFQilvkqxLMFkGneAneTN1PZAili7H2OHz2yrQ6PxrJ+oDq4AD1V/0xMG7vDGOjAqTVWNgKHMSUYiixxY6g5UgguSu8jfSxRfi3ljXHS4jRFXoCBj0z6etu2lFdjKeVMqaIffUAM2aARie7lgvMMBkGas4kHhvaT7F/jdrrgkO8DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfmLB2Pd8FsFKncSUIBbk8XA5qHqxQMUvxIQT4W24Ac=;
 b=aU91hncx0yH17LHrWQ+eakJYe2AkluPWpt5aQIYw5Kr0mjVGapzxnQtxi3a30cGMuhQbWdKb5+RrRXVJ7AiWul0T1IzCbsabeWygnt+uPNMVgc9DrBZsRoNlMM1z4q398etGJdb/zY/UVD5RnR5sgxgzFiKnW+JXv+IqPG/6yvxw/aX7VaESTY80RCf+yqiRZq2fUXx0NVPbcibhV2186PD67wn/i5YiM4RE42s4vREb8mdhbEpHsSZpsvcu/R1mouPjkdxuccIikdMkfDfs08g59E4mmjB14TqisRV0y+bL5SsX4b8p+atrA3e/m42hEQe+Tsi9QPtLmSqWVlW4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfmLB2Pd8FsFKncSUIBbk8XA5qHqxQMUvxIQT4W24Ac=;
 b=MoDP4eW8qzljT4ofhj/BMlUPKxJuc2Y7AtYctEweGsXOo44xmwhsS6gQEOdavcFv7D+Fq171f53pymavgqXT0rsgTDIOBn9Q3/HCkYkq6WvEN0azAfu2ZpegB9dGH8ktCOuhfQwapfvljnAKGoo6cZXzGo34Yc43pg7lwzVYsdI=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 11:45:28 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::99a9:a1a9:8427:d7b5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::99a9:a1a9:8427:d7b5%7]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 11:45:28 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Remove redundand kfd2kgd interface lookup
Thread-Topic: [PATCH 1/1] drm/amdkfd: Remove redundand kfd2kgd interface lookup
Thread-Index: AQHWT1AXkJcXz3pSC0O4IyFEGr7Ty6j0Lc0Q
Date: Thu, 2 Jul 2020 11:45:27 +0000
Message-ID: <DM6PR12MB372186B4CA42970CF2CAF551856D0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200701023330.23118-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200701023330.23118-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-02T11:45:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7fc1501b-8c08-4700-938d-00005abf7335;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-02T11:45:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 28e68ba9-1ff5-4065-9522-000049fef64f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-02T11:45:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e4c1a26a-e41a-4219-a41c-00005601066e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b40a2258-43a9-4700-d74e-08d81e7d6aa0
x-ms-traffictypediagnostic: DM5PR12MB1385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13853D87B14BD14A668F6869856D0@DM5PR12MB1385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5uStWLnU7S5WmS7wa/m99kLQUapPWdMeDIUs5ayD6vs6W6gAijiJBrSHv+pVrrWkIo3sexQfgXjhBmnbD3mzcS8KX3IgMJGBFZtqIZ+nX3x0LA+kabtv5V4nAUlb4gzNt8B4bHGOULffUVjZm7UKJ8fZUPKCtO7kbWxcAb8AsM1LlBzLV9dIgQOSk6hopmMbHNd7e5kKrKKDLXXW0+fZR5ckHUoOJcuM4lN+BNWCTyJZPmahbv8zsB5h+88K5x+TegY3aDO+uu+mI+X5L/uTkM1tz6pA8OgtFHjnWYGBGOr9f/rEzgxT99nPWX/3inji/eNywFhuggd9y3OnIZ2wqkLjLXbNWvKfDeKdK61dgHPT+Kt80bdGeNcvK1yB9wCMUqcBkR8qd0o3bUm5tXqrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(53546011)(6506007)(66476007)(66946007)(83380400001)(2906002)(66556008)(478600001)(186003)(55016002)(5660300002)(52536014)(966005)(64756008)(9686003)(76116006)(66446008)(33656002)(45080400002)(316002)(26005)(8936002)(110136005)(71200400001)(7696005)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7o+EL4nDEa1368U2wNWVeBsoOMixJo7BJX+AOntMi7aMeM7blOTOdeTEdYHRJwT9lieus0nRKlL7w+7vZkNg/veBM44rBhuG9kZqYV2o46K+uLmzXUE5Ll1/GOei/DlT4KqWEG3oQW4qm4u+rNG+emmZ6NgYavj1mJJuzvJS37W1GnSrKxSVKNCaCv7iMZRFnyRuZF4fIRAKbif119attCQEO4XV0rV/V4vNSBMdAogj5ufTnYP9jtR/MWt/0YH1sj/YasYO4XAqH3qBETDbjViSctMW9iAWMrYKumMvlUZQcSapij1E9+mV5tfTVDi7EMH9NXM3g8tX/9zXatmevHLJ89J8w7R1gUOFxqBPgJl0pWFqHbuURMcy1UAv7/YpIWdVawOUHdQpvk8tf4R2hLAl+9l/ZHb9vGATBe9Y/xMwljxrqPZtEoXu4EFvF/dXrftmubR5Kmeu2/Oyjq605EpnMXfcTA1gz69FALHHMX1UTu/2a7n+8aeQoofyzfKj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40a2258-43a9-4700-d74e-08d81e7d6aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 11:45:27.9867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgBFT7pXyctv8ewVoKVWVLEXEAtrcjgr+4H8JbONriDU/p4l2pOcIGtXE+PVf790dHw6ZJdGqiw0KUsOzmM9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Tuesday, June 30, 2020 10:34 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/1] drm/amdkfd: Remove redundand kfd2kgd interface
> lookup
> 
> kfd_pasid.c isn't using the kfd2kgd interface any more. Remove redundant
> code trying to look up a device for finding that interface.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pasid.c | 31 +++++++-------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> index 33b08ff00b50..2a07c4f2cd0d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> @@ -25,7 +25,7 @@
>  #include "amdgpu_ids.h"
> 
>  static unsigned int pasid_bits = 16;
> -static const struct kfd2kgd_calls *kfd2kgd;
> +static bool pasids_allocated; /* = false */
> 
>  bool kfd_set_pasid_limit(unsigned int new_limit)  { @@ -33,7 +33,7 @@ bool
> kfd_set_pasid_limit(unsigned int new_limit)
>  		return false;
> 
>  	if (new_limit < (1U << pasid_bits)) {
> -		if (kfd2kgd)
> +		if (pasids_allocated)
>  			/* We've already allocated user PASIDs, too late to
>  			 * change the limit
>  			 */
> @@ -53,32 +53,17 @@ unsigned int kfd_get_pasid_limit(void)
> 
>  unsigned int kfd_pasid_alloc(void)
>  {
> -	int r;
> +	int r = amdgpu_pasid_alloc(pasid_bits);
> 
> -	/* Find the first best KFD device for calling KGD */
> -	if (!kfd2kgd) {
> -		struct kfd_dev *dev = NULL;
> -		unsigned int i = 0;
> -
> -		while ((kfd_topology_enum_kfd_devices(i, &dev)) == 0) {
> -			if (dev && dev->kfd2kgd) {
> -				kfd2kgd = dev->kfd2kgd;
> -				break;
> -			}
> -			i++;
> -		}
> -
> -		if (!kfd2kgd)
> -			return false;
> +	if (r > 0) {
> +		pasids_allocated = true;
> +		return r;
>  	}
> 
> -	r = amdgpu_pasid_alloc(pasid_bits);
> -
> -	return r > 0 ? r : 0;
> +	return 0;
>  }
> 
>  void kfd_pasid_free(unsigned int pasid)  {
> -	if (kfd2kgd)
> -		amdgpu_pasid_free(pasid);
> +	amdgpu_pasid_free(pasid);
>  }
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C6064ff0aff58480be0
> ae08d81d673758%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7291676460049430&amp;sdata=pELFzqkP3isRtcEgtYkaaTuvGB4Xtf%2BrOp615
> PARX4g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
