Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80599C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2260864F7C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2260864F7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849D36EB7C;
	Wed,  3 Feb 2021 18:43:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE486EB7C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQKGBmsizVbda7As1t/J8JQ5mdzUG0riaORIUumIpDx5e0kG4WgM0mf2Yiel6cE2eBuAUEkB8IDpXQ2cMCou2BsfdOOWC+5YmYqGwcrabBj26b49c3uLd40/cb9L4EGRgQO2NJQiy6zdlVGLFLkKlvvCClNRMtPyvC0t/qMWIyV1IShP1ovWbjtj8VNCoO2zSjtZY0fGq8PD34+CHp1hrWyeFk4CUTmBW2prpToP+JwoKhjw+s/ROryXbEtK4NfFSYrsDz2Yu51OOUZOCVi9ganCQeFF3uqYbhpbofWwPSSd8bwgY9BRTBqvr8q5r7Y0DmhjXGqT4XvoHhfuxt3hYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiuKIZ06p7/AucmWai5JTmhUrZ3wgTeD+RJgD06Q5OQ=;
 b=gPjM/DA0FFeYfKbU0glPQ1I2OI75jcNxVucIiqp4bXLh+ku/rzgQaz6W+UOTTK5Nl72Wkb6LVR7z9HGOknos2OfI9jfTaWxHY65lK6U6Qr1CoaZtFiNQUEpoQ0R1vNSG6LIkKMisQ2B6v4GTYgLt1WmyQUccrRB8R7zAtHchRghSyU8q8gRpuzN9AG8GKc3NhDeErK2WzW1ugytbCyBozpFI0P9tOnVDiY/+B/yUYr1dRGYp4EHi/L9MkKdGLjf0HdOZUeYqEvagFL2Kuxywq3RPL3g5TfCjZi7a709SQxTdgEKIZ8eluITJxp5TWmUYKSgWztgLm9AvemKSFccOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiuKIZ06p7/AucmWai5JTmhUrZ3wgTeD+RJgD06Q5OQ=;
 b=yvecmwabvRFgs3394HJCjWOtEOmiBkAd/gT5kZXED4PbMm8IgxVTRyC9ca4DYwtdYRPxJ4y0S/z+R1oOrajdaeI4lypPDBwquofJames7w5YQV8ye7mrXudYabcILDzs2p+mtA6tlUZjzKCaGt38I4re4r3MFwohtql1F6vPQAk=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR12MB1564.namprd12.prod.outlook.com (2603:10b6:4:f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.22; Wed, 3 Feb 2021 18:43:55 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 18:43:55 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Print unique_id as hex instead of decimal
Thread-Topic: [PATCH] drm/amdkfd: Print unique_id as hex instead of decimal
Thread-Index: AQHW+lmW34ZXm95lBkSLqLaqEKi5VKpGwpoAgAABjRA=
Date: Wed, 3 Feb 2021 18:43:55 +0000
Message-ID: <DM6PR12MB3324285959A1056F69141FBB85B49@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210203182240.24259-1-kent.russell@amd.com>
 <26f70030-4c26-9c71-e4b5-d090b5d8cf49@amd.com>
In-Reply-To: <26f70030-4c26-9c71-e4b5-d090b5d8cf49@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-03T18:43:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dc262ed6-418c-4179-bb91-eef6360bf163;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.250.168.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b58185a5-0ab8-44dc-1cdf-08d8c873a92a
x-ms-traffictypediagnostic: DM5PR12MB1564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1564499FD24801D1408EF38585B49@DM5PR12MB1564.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWLPN+VNrHMmHAQQQ9BDdsaRxLLe5ZtmZxZLpEu8B70TijAff7bgrjZF+ZvH6gl+WBFAoycWn0uBAnYF5HUvSF5iYu6uwrGTbFZHtmR80W6Nr0NvLDga1o9Ql65GksQAl5GiN5xs3hekELv3+9aQicFYXaLZcJRDLkzQS7wrPJiRk3TU+sp4OFahYqtlTf5/mLdhq+R0c/4xvmCxvim+o00mUSLfhLHOUbENMc5Usi9CwSgofQEhek8CmhpYyl8k9FqyPDBJNVIdqzkIAj4n+oFkihIIpXRKv8FTCI+HYs4AZKuvh8Pk8NlHFQlg9yvdqYmL56huryMr4Axl49zjlEqS/M8gEfhECDY64RkCEhHPsClMnOXo4lJwhwYx/tPOa/q+BHj+YFcSirEmMta/x8tRGE5cnyePSY4y3QMF9AMVd41hGui3OM5jFKl8pOtkSBtniMFaErgKcyDmCydypcufGBdyHx8/sUhxQxbWD1KXFfX1P3n0Pmj5rKdoblEMUDsuxbXDzvXe/IVtQS9vqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(9686003)(33656002)(55016002)(66946007)(6506007)(2906002)(7696005)(53546011)(83380400001)(66476007)(66446008)(64756008)(52536014)(5660300002)(8676002)(76116006)(66556008)(8936002)(186003)(26005)(316002)(110136005)(71200400001)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzNwUHgxN1dEMEpzbC8zVHI3QVZzZGhJZEJYcEZlWGpYaTErWDRsY2dHcGRx?=
 =?utf-8?B?eVFMWSsrSStKckl6MkhUK2xNYi9PN0dKQjFEZ1Q2Y2Z5NlFtcDdlOUxDVG9r?=
 =?utf-8?B?L04wY3ZMYzlGaVFoaGt3dnlQU0FtaFMwUnF3SVBFRm9Hd0MxaDE2dFczZDE0?=
 =?utf-8?B?aHZ5a3NGRUREb2tWWHFuVzRsZFhhbzUxbEswYy8vSWhzdVhpcyszMjRYM05l?=
 =?utf-8?B?cEI0Q0R2dy84NXJhT2NaaVRXUkxLaTIxRGhiTTM0Si9odyttb05CMk9vSi9V?=
 =?utf-8?B?UGdDM2UwdUt6VkROR0Zsa0ZZVm1IVEY2clVkZTBHSnUwaXhSKzBvSWFmTExK?=
 =?utf-8?B?S0N1TmhwQ2NyblNnTEI4aWZtell5Zmk3MHFFWTlEdE9JZmNxZWsvV2cwbVZu?=
 =?utf-8?B?NWdJZW43OUlyV3FmckRBUEIwNDExblNWamdTMkJ4bjlDTlAxL1dGNEtGeG5o?=
 =?utf-8?B?ZUdIeEZxYkk3TmViRFBTdTRyeUlTSmJQaXVDem5Kb29SaXUrZjRzV1dpOUJh?=
 =?utf-8?B?NVBjay9jZFNHS2hnL3JGcVZ6TlhKa3ZPYmUwbzB6NUZhM1hhSDUveUdjTFQy?=
 =?utf-8?B?aE9Nak1mQndPdm1RaENFNVhTanY4cjRpVnhUdWZ4UmF5WlpFRjhpU2wvVEdn?=
 =?utf-8?B?WDNHWDM5bHAvYUJlRlZYZjVZbXlnWXNaeVk0eVRvS3JoZzZ1eDVvMm1naTJF?=
 =?utf-8?B?Y0hGWFFaeWNjRktVZk9HcFJ1VWtseHdsamhpWGFCL3Rkais3NHVGNitLanhw?=
 =?utf-8?B?bjV6VmhaU0VSVWxHWnNBbC8xbk9iUmtOQVQzUTJkcUlSTjk5VEkzQ0JvRmVL?=
 =?utf-8?B?eGE4TzhmQW9pekhOT0toaytoK215d0RMWVArS1hIaVRYZTVBQzVsbmo4NUQ2?=
 =?utf-8?B?cU83Qm1hMll3Wlg5ZURoQjdaa2NJWG9mWVZsZytCaCtUS0JETDZHaThpeU1v?=
 =?utf-8?B?bHZFRDVTUURjVFY5WUJSUjJPVFFyN1BpemdiUG5MeXliOXMvZ0RmakNVa21Z?=
 =?utf-8?B?UjMyZlp4eVpIWXVzSHBOY3BESi83cjUrT0pwNjh5YjIzZzFSMG9nRG5kVkV3?=
 =?utf-8?B?MWJjWk1ORWhmZUtlc25DNTh1THRpcmxvN2h5QXVFN0tnT241dUV4Y1dtb0RR?=
 =?utf-8?B?RHRvT1QzaGY2WHZ2K2VPem8yYVMxWlZjV0cwOUtWNVc3RTliaXI4VEdtNlha?=
 =?utf-8?B?WmpMYU16cTJlNmcwVUNXWktLNUdQVVZDK1lqOGtIZk0yc0VvUVhJb3VBeFJp?=
 =?utf-8?B?ZkF4QVp4bnY5bUJ5S3lsRDRoVWsxSi9vMjR3MFBadWNYZFFJZFpsVjVpSkpS?=
 =?utf-8?B?TzZUbTRRd29VQzNHKzhqRjRQVm9GL2lsa0VjSDdGbWIySVVNVU9zaEF2V2hU?=
 =?utf-8?B?MHl2ZlhET2lacUM3VjRYTUJZOWd0THlCTEpHa1hFNXU4K1FQekVGdTBuRzRM?=
 =?utf-8?B?Z1Z1TkJiVTZla1lIYnZWTGd3SGUwSnZyTVR2R25VMzh5WHZqbHFxS21HWWFu?=
 =?utf-8?B?WW1za2xxeGlCeFY3c2NBU0grV3paN2hhbjhBM3JEVGxJM0tMTmd4TDh4dU01?=
 =?utf-8?B?TFlqY0ZXTGtDNFRlQlFsRDRua0xHRmVDQlY3SFFPQUN4YURnRWNqTFdYM3Bo?=
 =?utf-8?B?endGZUlCWVhSSUVuMWlXczNNMFZ1OW4weElqK3VKdjJmSUJDL3E3MEhTRllk?=
 =?utf-8?B?M3ZXUFFnS0R2cVhUTFlxcDhLcUZvM2FLaEdDdjhBRHB5WkNuWS9yWTA0SmRE?=
 =?utf-8?Q?ub+MuleUiTfqreRcuG8b4kBsaVCb7L6azqUNZFn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58185a5-0ab8-44dc-1cdf-08d8c873a92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 18:43:55.7319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56PhoZZYmzqmlC1FVc3e9eT8fWCGcjFridtHRRgXf52Bs/PJe6T5rSQbm0iOJ1iza1gBQ+jxUGdVACLRsSHabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1564
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

Indeed it will. Consider this dropped, as no one was asking for it anyways. 

 Kent

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Wednesday, February 3, 2021 1:38 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdkfd: Print unique_id as hex instead of decimal
> 
> Doesn't this break the ABI?
> 
> Am 2021-02-03 um 1:22 p.m. schrieb Kent Russell:
> > Add a new helper function for printing Topology values to support
> > printing 64-bit hex values. Use this for unique_id to ensure that the
> > unique_id in KFD's topology matches the one in amdgpu's sysfs pool.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > index a3fc23873819..4e4f651dcb88 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -217,6 +217,8 @@ struct kfd_topology_device *kfd_create_topology_device(
> >  		sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
> >  #define sysfs_show_64bit_prop(buffer, offs, name, value) \
> >  		sysfs_show_gen_prop(buffer, offs, "%s %llu\n", name, value)
> > +#define sysfs_show_64bit_hex_prop(buffer, offs, name, value) \
> > +		sysfs_show_gen_prop(buffer, offs, "%s %llx\n", name, value)
> >  #define sysfs_show_32bit_val(buffer, offs, value) \
> >  		sysfs_show_gen_prop(buffer, offs, "%u\n", value)
> >  #define sysfs_show_str_val(buffer, offs, value) \
> > @@ -497,7 +499,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute
> *attr,
> >  			      dev->node_props.num_sdma_queues_per_engine);
> >  	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
> >  			      dev->node_props.num_cp_queues);
> > -	sysfs_show_64bit_prop(buffer, offs, "unique_id",
> > +	sysfs_show_64bit_hex_prop(buffer, offs, "unique_id",
> >  			      dev->node_props.unique_id);
> >
> >  	if (dev->gpu) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
