Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A79C47083
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B2B61407
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2B61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F84A6E0BE;
	Fri,  4 Jun 2021 04:23:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166EA6E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 04:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNcisYeexyBTkk+2/DSSugsVZSs+ajiIEXjBkge+vOC8BSVc2od/z802H8CdQrC/80A0mLMEIYQcF3+BXlem0qRrVZeofbICt3A8WN2KnBqdHtngzU8G0IDEBebMcOjvAJzuOw/gBj+NIxHk0G2FZpJM9Kvi5IxCPPoQb+RL9vsMcl/YJ1TYbtxSNCZ8aqYkLb6MfFCgHogIkCTWp7hP6wSiTkAhAJh8XYfm8tHE3rs+3u0lk4LqpwFijiYiv4cTqhhsAhwDlJPS+Q0inF9GtbcHH516LWyBlwdYxcXpgMEY/j0Wj3U5vWKNo1FHQAntPPQpUKAGg3lRzlHiQ4UdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XO1943Co8UU+6Hg1uqqzukCSfl7P1DR65dt11qN7Pw=;
 b=UWCyIM4ZfJqzc15wDzXofPppAL26v6+CH+KekydWbGMQpie9Oimywv+EWrWbUfn5U/CbZMd7T4wg7vFI2XR1OLmm72KO8Y9WTj7kcWvkMXcbkW9dWr+VXVJcGvQ0H4miNduMFISQgJBolujsyiQkBF3hLFnh1EY9HFS0XIq1xtRivrfdv8Cqvx4vaZ+HxI6Kyx9nBZFkrdUawNHoFXE+vyZEiu5fCjIeuYrUmC6GNher++pI9jJayGbXy6fMnD0odVyUG/0ciWHNhtq5fzuRphDrxv6k4O97/8aYaklwMSyPrEsdFS+5CtBG3CBuYtzHOmpeYcE/Xl32kJ8ZoSfuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XO1943Co8UU+6Hg1uqqzukCSfl7P1DR65dt11qN7Pw=;
 b=DE8BRf8lP52NUpEI7KyKkcaJLDC2ku2Nzex4O6mWU7DIUQANkjRV9IZ9NTiXRU0bJQr65i6PmawPIBI4ll/6HOOqsLwov9uFVz5xU6L0Rce8wWxNuqq9lLJPIORZS63419QegFbFoY0QBIH/Vyv+zrXfXQakrTX3xwZhSwgF5uY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Fri, 4 Jun 2021 04:23:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 04:23:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Topic: [PATCH 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Index: AQHXWDTUU6HrgsbnDUGTLPbqKnnWjKsCH/sAgAEiJwA=
Date: Fri, 4 Jun 2021 04:23:22 +0000
Message-ID: <DM6PR12MB2619FB3D68A5CAD25282C7B5E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
 <20210603045603.977998-4-evan.quan@amd.com>
 <1a396a96-3c99-1e16-b170-75667c97ccfc@amd.com>
In-Reply-To: <1a396a96-3c99-1e16-b170-75667c97ccfc@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T04:23:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b41999ad-4586-422e-808f-e8bc5baf4ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82093838-5ba9-4b1b-1262-08d927107d50
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB170823725AFD0FF9041D66CBE43B9@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfqj6st4Xr1WQaL5PL+Ug2wbqV/VdeWJGLkU7qVmKP8Xuha0o64FqgFktLW9yqSTyDAKGWzadYxqZanaA/KDzVXg3w6Jt0nY9spwL87Jj5LIYX2Un0LImd3PpJ1yaUkAB/uQplsEvExJyh0+9jsQ3wMLX9uYNtHgR/BQ9/mwiKIq+28Q52vcfCj+YcUEJZoOwvjlF4CtoC/Y2/W1wNAJevFN1nZSRy5DA11GHIZfs9sisTzbMtsEAZ9biwb0OWcwQ3RXFmicVBsoXTQATYMm7fx+gWBoKpdk00km/IZ1ExqqrmYKygpEAT67kND0XDs+axN3Ih2AVwAfsmzjahsZ8E8UiLKc42PgZjWcUETF5f/h89kaJcVzH5Esu82HsYWrjxxGguOFaK3+ePvZ3INFsbUHA+A5isaM81vOkE7C0BjhcDdbCbdaByZlEGXg6OXZKB9XyoADRMorRWSUUpW7Mq4xxyGGmeOkqq+Uo2lYdbTNvnTvOzTsofH5YdoH8kL8Ingn128t1O6hyr/moupc7ml14WdJIDmgPhax/EHWq7RuU7vawa/IbNzVAKY4NOO+23PgCgw76RVUn5h8SebngHx6iQ+5gh93+7sp3SigCjk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(52536014)(55016002)(86362001)(5660300002)(83380400001)(4326008)(478600001)(9686003)(2906002)(33656002)(8676002)(8936002)(110136005)(26005)(316002)(71200400001)(7696005)(53546011)(6506007)(38100700002)(186003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?akEwU3NBcTQ3bHZJVHBPRlpTMS9yZVhrTndrMWVKciswTTBTTlQzRk5paFdr?=
 =?utf-8?B?empaZXNaZUl6RW4zc05sMVFENUpRb0h5YzIrSUtOeEtERWJkKzJPc2U3WDU4?=
 =?utf-8?B?V1B2U1lDbkRMMlkycU85YW9wV2NsRnRPTWZhZHNXOXNxOEladTlOWWpxVGh6?=
 =?utf-8?B?ZmxkdEdSVEtmcDVzQkxWaVRvSzBXTGRPRFNtcE15YjRQTFY0dnBaTmVmZmUy?=
 =?utf-8?B?WHFRK3B0QXdMVnJFYUZlUXZONGtCR2hJV0tRajlUSUo5aXRjaUwvVHRodkx3?=
 =?utf-8?B?M2pBU0t6Nks4Mmp3bThIQmVWSzhJSTZlVWNOaVJzV1ZYUUo4cGNhSmRsNHhv?=
 =?utf-8?B?djBmTGhZMGc1Y1JtN3lyaEFKUXQxQVFuaUMwQzI1eHV5SkZXa3hMQTJBYlB5?=
 =?utf-8?B?ZmhBNXIyWkJ4MW9idDdKTjVVWDZ4MWMzQ0Y5VzNIcE4wY1VMYmFKbFRrdWdM?=
 =?utf-8?B?TE9vN1p2UzJLZVBtNm00alg3WURLOEtyMHo3MWtSbUY3M3NGUkpjZXp5Nzl3?=
 =?utf-8?B?VmUwWllRQk5nNWFteTlnZWs4aWJHQnk4QlVKVWtmL2Nzb2VxQThWYk9kdzZ3?=
 =?utf-8?B?TXdQakp2OEI2aWNudmxJaUJrczNnZXJPcGIvTVhLNzFKUnZHemJGa2RwNC9p?=
 =?utf-8?B?SDJKRkRzS2dhT05TN214V2JMbjBqVTdHSXdwN0JubFlTNDdjVzEwdDdHZUVE?=
 =?utf-8?B?ZjF5TkJyVE1vNmI0VlBUaFRPVmhndVZRbkE1aE9KWDBYZ3JEY1JPQWdNTEg5?=
 =?utf-8?B?ei9mektJYlk0cWhYTUlrM0s3UFZzOFArTGRFMHNzNWxvWXB2dG5SYnhlRkdX?=
 =?utf-8?B?Uk9NdkticmZLWFBIQzd2cHpKekFVMTdiSlRKd1dvYS9wY0JjN0NCbTNBdm9S?=
 =?utf-8?B?RjJ5WEprV0V0cTA0cnBEVTdvZHltWEZwV1hROXBMN3VhaWR5dm5YLzhXdFJE?=
 =?utf-8?B?QnQ4Uk04THNadkd3Y1VWcmdYemoyaGN0ZVZGRWxmaU1FMzZGUWpUQm9EQTlJ?=
 =?utf-8?B?aXFYRGgyRnpjbVA0M1dXRXNHYzBKOUJ5OTJmM0hnOGliZHFyQ0I3MlppdU1C?=
 =?utf-8?B?clYvK1hpcTVpeXVPWkxkR2NYQWtJVmdzNHR5aFE2OGlMQUhhZXlkR2ZBTG9w?=
 =?utf-8?B?bFhnb3NSMFduNm9zR3JOSzJsWlBzc3QydzRhWmJXYm40elFxY3lwM0swUGVL?=
 =?utf-8?B?blNXMDNlRWxaVW1qZ2NzRzBWSmEwd2FTTzhhaVlkQzBuRE9UWHE4L2YrRFVw?=
 =?utf-8?B?YlNIdXdnWUJlcXlZUnJOOHk1TW5mN1ZicVNONGcrdC95NnhzQ09HdFlRSlBF?=
 =?utf-8?B?Z1dlTE1XM3FZTTc0MkIwMXJBVHc4RUpYWWpCRFl4RnA4Ny9URGNUK0ttR2dN?=
 =?utf-8?B?N3pCNmZLbGxtUDJYOUZycWc2anlQSnozMXJPNll5WTNMNEl1VUdsV1lkLyt4?=
 =?utf-8?B?anRLZUtNRWdpdHFQVUN1UG4yTlVnNGErOTRrVjBLVVJHa1FOcFdnZEUyL2Uz?=
 =?utf-8?B?bHFjeEpXU0RGZStHTlkyZm8wdUQzMjY0SEU4TGdrY2pZUnRlV2VaZDNONXM5?=
 =?utf-8?B?NHpPK0REWHhtUVkzbThTVTlpRmRYV0FkbVZZcFBqMzRhdTQ0eUFHZkFFWENx?=
 =?utf-8?B?RzR4c1Eray9lTmVYcko4aGpKK1RielB5T2drL3dEeG9RVUVoc3ZhYm5Od3p3?=
 =?utf-8?B?djZSTDBvc2F3WFVlVDFabk9nbUlxOUVMV1RwSldHNjhVTTJPWURqUHNxWk9H?=
 =?utf-8?Q?7fAbUc4YWGP7+E8JBBxMydeU+oFKTi5ZbmFRD9K?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82093838-5ba9-4b1b-1262-08d927107d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 04:23:22.3326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHRV97fCuoRaWH94UAWPIK7jfs4miLMlmfcPbf8AXHXKgFmEqGvIhut4ZQiBCVhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, June 3, 2021 7:04 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 4/5] drm/amd/pm: clear the cached dpm feature status
> 
> 
> 
> On 6/3/2021 10:26 AM, Evan Quan wrote:
> > For some ASICs, the real dpm feature disablement job is handled by
> > PMFW during baco reset and custom pptable loading. Cached dpm feature
> > status need to be cleared to pair that.
> >
> > Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 18
> ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index c9a31556e077..fd7b1b8edeb7 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
> >   	return 0;
> >   }
> >
> > +static void smu_reset_cached_dpm_feature_status(struct smu_context
> > +*smu) {
> > +	struct smu_feature *feature = &smu->smu_feature;
> > +
> > +	mutex_lock(&feature->mutex);
> > +	bitmap_zero(feature->enabled, feature->feature_num);
> > +	bitmap_zero(feature->supported, feature->feature_num);
> 
> This will clear also clear the BACO feature status. Won't that affect using baco
> exit for runtime pm resume?
[Quan, Evan] Yes, you are right. Will update it.
Regards,
Evan
> 
> Thanks,
> Lijo
> 
> > +	mutex_unlock(&feature->mutex);
> > +}
> > +
> >   static int smu_disable_dpms(struct smu_context *smu)
> >   {
> >   	struct amdgpu_device *adev = smu->adev; @@ -1374,16 +1384,20
> @@
> > static int smu_disable_dpms(struct smu_context *smu)
> >   	 */
> >   	if (smu->uploading_custom_pp_table &&
> >   	    (adev->asic_type >= CHIP_NAVI10) &&
> > -	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> > +	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
> > +		smu_reset_cached_dpm_feature_status(smu);
> >   		return 0;
> > +	}
> >
> >   	/*
> >   	 * For Sienna_Cichlid, PMFW will handle the features disablement
> properly
> >   	 * on BACO in. Driver involvement is unnecessary.
> >   	 */
> >   	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> > -	     use_baco)
> > +	     use_baco) {
> > +		smu_reset_cached_dpm_feature_status(smu);
> >   		return 0;
> > +	}
> >
> >   	/*
> >   	 * For gpu reset, runpm and hibernation through BACO,
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
