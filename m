Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DEC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A5664FE6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A5664FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2373C89C61;
	Tue, 16 Mar 2021 15:59:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBB289C61
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 15:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdCznT76YL0sB1+JZM93UaavmNezs8OVKoSkGJo7roz1HYY9O1Z/4DWdhD+r/IQrRwIPgWS56ZM2IDxY7+KwI4LScUqXxnJNAWMEQHUG075AjH+DxLm/4VfgPkv/v5049wLLz/u92ySbdSN18CqCaPLJEV6j9ije/AQux2bXa42i8YSDOv+QtPH431r7KJnt7vLjHeTPXZ3spY3aF2BKKaoC8a3zMM89FX4/z1pyBrqkoBVKTrsJrYLS77vx8R/dixdJqXZzQarYLGr/u7GMzIo+sWn3OYrH4HMtmdVFyr24boNjfkCEeGyf/cENhHVY4GJhrBaqfn88DtfXFk9C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAAt25jwkg3Tax166ClS+j6K5JcdX1R0iPGgUaAExN8=;
 b=dqKUnvuaisI6xZ8sUgvdqI/dX19Q+VinGEz93lfLm+oV0EjIdGxddLK52STwQ4EdqYtDqhrLM0o5QA9iS/9QF9gJTUJkXvt0zERdnkA/1Q7e72hq9G+YZbyuo0MccRDM/5RS4O7uYfjwUdvaqDuMn/FV8Le829lzr/SX0IN2Oca+myVx932Ppw6NBlC/o0docLoXorWQU1N7e78B3Om2QN8LzNIFeb25WyS87sikd1/9p5xNAfAmWIEW6m72FyQePgfsMmQe3AStH5+5dNsWXzUjik7pzZlztanzHSzBMGDo8qbNzN5J6+AhovaED5rdLcZISC5YBDiDeHMrYANiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAAt25jwkg3Tax166ClS+j6K5JcdX1R0iPGgUaAExN8=;
 b=f0Vu47eH5d6VgCbxF1io6sun+w0IMv4HsHyuZvt7K3fqrZlnFBOrjylsXLose66cPotFZFnku08pC3lWPQy0B2ztahNBYv+ZqmEUxpS390U1VuPhd6qaW2OoxuC0kQs8vPF5/dwZ+uA8Dla2rxhtM+tgg2MJF5D7kx9LLLGowws=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Tue, 16 Mar 2021 15:59:31 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::595e:20a2:f658:a7a5]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::595e:20a2:f658:a7a5%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:59:31 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "Revert freesync video patches temporarily"
Thread-Topic: [PATCH] Revert "Revert freesync video patches temporarily"
Thread-Index: AQHXGndhgjTUyray50ai5sPNljqiLaqGw4cAgAAAk/A=
Date: Tue, 16 Mar 2021 15:59:31 +0000
Message-ID: <DM5PR12MB46799C62D1DAC886C5F05DC8EE6B9@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <20210316151556.4299-1-nikola.cornij@amd.com>
 <0af2bffd-a124-e1c0-31d6-fa4fbedbe758@amd.com>
In-Reply-To: <0af2bffd-a124-e1c0-31d6-fa4fbedbe758@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2021-03-16T15:59:29Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=1a9bc3dc-6f03-4cfd-8cf0-cc011da9e448;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0a379b5-0db3-4f44-06f1-08d8e8947c84
x-ms-traffictypediagnostic: DM5PR12MB1644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1644F88E913EBC83E8E1AA40EE6B9@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kXM/mxTbiQ/uw6coevf4NJ8cnuPqAbPnIQ2zS7qOKhjkISph/KCdk+t5Yj2ReVknjLoqwJmUH8NgmjEMKbj//JsrZrxFrw8BamPRVfmRxXRUMI2JMPrJ/SanSGnhkG04JlZ+d4GrFIr2rAvoNG4P2Q8h1Cd21bcpfBrNbFLVBw9v9//JocTzjomZsYQr6rrnJFlhb3hme9FXS0FJxDHvvdoRyeVBoTKi0dD+YO6lDZN2LQD5GnbPoeNmaNOsd5JPQ4N9z5J4mO2SQdjwm8XsUJO3alC4MHLsv0atC03DW1VAxMnRdhC64CTASVxi9qeMLKRq76JSnTcK0i5EzkmA2nYJE2yLYkkYl85fnBxGMxpDVUgOmz+RoNNaUBPYdbuF8Ee0K07Goz56n/CSUkQ4SuVvDCTIGse60m5rW3PSgtxl4zb5cePg7haRQTpEfUwI0+lHEbbnxc2S6lIBx2+/4z1B/n1wMv+GxyXg4BN4QS0IQIh1ndmW1DK+dBGJ6VqgQMG2V4B1xF/g8iAGJ9OFmkAORWDLJAYqggZGDHh4x+sfUCvGt6IvpTb+2WswG/3X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(4326008)(26005)(71200400001)(186003)(316002)(110136005)(33656002)(8676002)(83380400001)(2906002)(9686003)(5660300002)(66556008)(8936002)(86362001)(55016002)(64756008)(53546011)(478600001)(66946007)(66446008)(52536014)(30864003)(66476007)(76116006)(6506007)(7696005)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NjY5UXp1S0V4dHdZSFRXZVR5aTBwQmpoTFdxNnFrYmJQSGRNc1pXa3ZlaktJ?=
 =?utf-8?B?RDlBZnZ3UVBDNDh4ZjhqeHd6NjRCTHZtUm9MREpJZ1ZMcUFQNWg4eUplRTJY?=
 =?utf-8?B?ckJnRmJmbUk3UzhUWk1Jd2dvd2pSSTlSSTcrTUVNcmwxcmltQmY0d2p3aHJp?=
 =?utf-8?B?U0RNYXdRcVJpSnAyaHVYbmxVcEhJMVJvdDlEVkdibDJEOWtIZkE0RjlYb1Y2?=
 =?utf-8?B?c1IrdjIvSzF3MlZuQzZ6eE9CMWk3Vyt1MDdhTm92YTlkVU84aThhN002cytO?=
 =?utf-8?B?TFVTMms4cG56c3ZyYVdNdWtnN1Z6Qkk0Q2UyVFdDK09WY2ViUTd2Y1NkWmtr?=
 =?utf-8?B?SXU0cTVudU05TjJEY1BYSklpdVdhWXBmSTh3bWRJWE9wbkRwcGFRMnhVejFw?=
 =?utf-8?B?VExCZ2JxSWY0WStyeThPMnF6Z3JXVWpucTUvWVhDemEwdldvOTdZTHNSL3Zz?=
 =?utf-8?B?cVdsOVljaGl0REFTK204eWtiVEw2ZEQ4M2xJLzlnOEFKdnJCM0NENUhuRkNl?=
 =?utf-8?B?UmJhNW1CK1hoOW9uZHpCeWlSQ21TcUZNelJ2Smo4aTNkRUpXdjltRDd2eHdI?=
 =?utf-8?B?bWVjZGVHNXRlZHpFREt2MklRNSt5dHN0bnIrTU9Td2tTUkl0VVYyQzVSZkpy?=
 =?utf-8?B?Qm84L1AxUUdHQWF3elNQaUVOUHpOTEUwSFZYZVhVTldTbkw2TGt4M0MzWVlF?=
 =?utf-8?B?UnR0MldmWkpNSGF2NzJGUjNyM0ZRVnJ1SmYzWDdTdzBMd1E5MW95K1FhL0ZI?=
 =?utf-8?B?R3lJbVIxR2pmaG4vckVpclNQb1FhYUNXcWRDOFFWcHNENUJwc2xhYURDYkNi?=
 =?utf-8?B?WDZyVVdtZEpzZ3lkYUVMU3VHVXliOC9iTkpMb2UyeXhUVEVrRmN0eUZqRTcy?=
 =?utf-8?B?RlVhUy9lSCt0THhEQ0I1bTVXanlJdGhOVW5rWENSSFlmVzdIcTNqTHFvWG0v?=
 =?utf-8?B?UTMydmVHSCtaMHRnQ2tzN2JsQnQ5TEFMNzVtWFFhYmlOckorRDdLZzdHNzBE?=
 =?utf-8?B?bW9aRXR2RWo2Nld5alR4blVLT1Z0ZUYwZGZQTEErWUJnY3p6QzIrUjhDNHpu?=
 =?utf-8?B?WTh5bmtvZjV6em5rN0pIQTVMUGg0SCtCTy9jSm9kL3hIbjIrd2wxNjBpUWZq?=
 =?utf-8?B?THllM0lBc0hoSHV3UVFCS2FUbE03VXpxWkZCc0gxb3AxS2VhSHlVNlB6VCtt?=
 =?utf-8?B?TC85ZEhGZk5XQktibTJLeWUzaTl6OHY5Zi9PMlpPZHYvekRLNkpHQzNOc2Vy?=
 =?utf-8?B?MEhOVENHazgySGYzT3NMUTR0QUdVTFpyMHJkYkhBOGd3VytxMXQySUJvMXhn?=
 =?utf-8?B?WmFPWXQ2eGFsRTBHQmw5OUVJb0U2MEJNNThIZSsyc2dvRGJYdlMwc3NOYW5R?=
 =?utf-8?B?VUthQVFIYno3cWRveXV1UmI4VDlPQ05MSlNFNk9oVnZnRHJNQkN1S2FtWUVS?=
 =?utf-8?B?MGRLSmZweEhuZERXZFozU1VXczh0ZXJLakFqZk5hUWx6UGpOUVcvRzlxR1Jv?=
 =?utf-8?B?NTI2M2h1aDAwQ1R1SDVIWldZQkhzckdVYjJuVFhKQnhiVWdmMnAwVkR0UE8v?=
 =?utf-8?B?blBqT1JPNUxoYjgzbExmay91TmNBbzBuLzB5QXpkdXUwSTF3eFRYdWxHd2hM?=
 =?utf-8?B?UDhGYmIxbWFuWVUyNDBhNUp5N1U2VnkzNTJ4ZGNuOTdvV0RsM0xXdFdRUjF4?=
 =?utf-8?B?SzFzcVpJU0VPeHBjVTZadUVXWlFkWHpHaCtqR05ndEV1ZUN2V213WTJKbkdw?=
 =?utf-8?Q?gJACRdwULIDbE3T6uFrZGZiLX2Q2KRQfX1buylu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a379b5-0db3-4f44-06f1-08d8e8947c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:59:31.3417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMAo7O15Fs0ErNPLc4jphbsNeODiPKgByOWWy15xF6N8eFVSRKLnReWycNi/2r9UWiX+eEgQ05rM1bb0c3r9sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Approved for External Use]

Oh, no, I already pushed it without it :-(

My thinking was, the initial revert explained why it was reverted, and the fact it was now being put back in (implicitly) meant the regression was no longer reproduced with the most recent kernel.

I can put a note about it next time though.

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com> 
Sent: Tuesday, March 16, 2021 11:52 AM
To: Cornij, Nikola <Nikola.Cornij@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] Revert "Revert freesync video patches temporarily"

On 2021-03-16 11:15 a.m., Nikola Cornij wrote:
> This reverts commit e9a777fc0c264542fbd6d51b8fe51739d09032c1
> 
> Sinc this is a "revert of a revert", the end effect is that freesync 
> video is back to its original state, the way it was before the first 
> revert.

A brief statement describing why it was reverted and why that's no longer an issue would be useful.

Other than that this is
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 369 ++++++++++++++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
>   4 files changed, 349 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5da112b3feb0..428b9f2d38c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -189,6 +189,7 @@ extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_freesync_vid_mode;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dm_abm_level;
>   extern int amdgpu_backlight;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1be42edf84d0..d6a9787e5597 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -166,6 +166,7 @@ int amdgpu_mes;
>   int amdgpu_noretry = -1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = -1; /* auto */
> +uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   
> @@ -828,6 +829,17 @@ module_param_named(backlight, amdgpu_backlight, bint, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: freesync_video (uint)
> + * Enabled the optimization to adjust front porch timing to achieve 
> +seamless mode change experience
> + * when setting a freesync supported mode for which full modeset is not needed.
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off 
> +(default), 1 = on)"); module_param_named(freesync_video, 
> +amdgpu_freesync_vid_mode, uint, 0444);
> +
>   /**
>    * DOC: reset_method (int)
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = 
> mode1, 3 = mode2, 4 = baco, 5 = pci) diff --git 
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8b464debc1ef..553e39f9538c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -212,6 +212,9 @@ static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
>   static const struct drm_format_info *
>   amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state);
>   /*
>    * dm_vblank_get_counter
>    *
> @@ -335,6 +338,17 @@ static inline bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
>   	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
>   }
>   
> +static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
> +					      struct dm_crtc_state *new_state) {
> +	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
> +		return true;
> +	else if (amdgpu_dm_vrr_active(old_state) != amdgpu_dm_vrr_active(new_state))
> +		return true;
> +	else
> +		return false;
> +}
> +
>   /**
>    * dm_pflip_high_irq() - Handle pageflip interrupt
>    * @interrupt_params: ignored
> @@ -5153,19 +5167,16 @@ static void fill_stream_properties_from_drm_display_mode(
>   		timing_out->hdmi_vic = hv_frame.vic;
>   	}
>   
> -	timing_out->h_addressable = mode_in->crtc_hdisplay;
> -	timing_out->h_total = mode_in->crtc_htotal;
> -	timing_out->h_sync_width =
> -		mode_in->crtc_hsync_end - mode_in->crtc_hsync_start;
> -	timing_out->h_front_porch =
> -		mode_in->crtc_hsync_start - mode_in->crtc_hdisplay;
> -	timing_out->v_total = mode_in->crtc_vtotal;
> -	timing_out->v_addressable = mode_in->crtc_vdisplay;
> -	timing_out->v_front_porch =
> -		mode_in->crtc_vsync_start - mode_in->crtc_vdisplay;
> -	timing_out->v_sync_width =
> -		mode_in->crtc_vsync_end - mode_in->crtc_vsync_start;
> -	timing_out->pix_clk_100hz = mode_in->crtc_clock * 10;
> +	timing_out->h_addressable = mode_in->hdisplay;
> +	timing_out->h_total = mode_in->htotal;
> +	timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
> +	timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
> +	timing_out->v_total = mode_in->vtotal;
> +	timing_out->v_addressable = mode_in->vdisplay;
> +	timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
> +	timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
> +	timing_out->pix_clk_100hz = mode_in->clock * 10;
> +
>   	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
>   
>   	stream->output_color_space = get_output_color_space(timing_out);
> @@ -5332,6 +5343,86 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
>   	set_master_stream(context->streams, context->stream_count);
>   }
>   
> +static struct drm_display_mode *
> +get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
> +			  bool use_probed_modes)
> +{
> +	struct drm_display_mode *m, *m_pref = NULL;
> +	u16 current_refresh, highest_refresh;
> +	struct list_head *list_head = use_probed_modes ?
> +						    &aconnector->base.probed_modes :
> +						    &aconnector->base.modes;
> +
> +	if (aconnector->freesync_vid_base.clock != 0)
> +		return &aconnector->freesync_vid_base;
> +
> +	/* Find the preferred mode */
> +	list_for_each_entry (m, list_head, head) {
> +		if (m->type & DRM_MODE_TYPE_PREFERRED) {
> +			m_pref = m;
> +			break;
> +		}
> +	}
> +
> +	if (!m_pref) {
> +		/* Probably an EDID with no preferred mode. Fallback to first entry */
> +		m_pref = list_first_entry_or_null(
> +			&aconnector->base.modes, struct drm_display_mode, head);
> +		if (!m_pref) {
> +			DRM_DEBUG_DRIVER("No preferred mode found in EDID\n");
> +			return NULL;
> +		}
> +	}
> +
> +	highest_refresh = drm_mode_vrefresh(m_pref);
> +
> +	/*
> +	 * Find the mode with highest refresh rate with same resolution.
> +	 * For some monitors, preferred mode is not the mode with highest
> +	 * supported refresh rate.
> +	 */
> +	list_for_each_entry (m, list_head, head) {
> +		current_refresh  = drm_mode_vrefresh(m);
> +
> +		if (m->hdisplay == m_pref->hdisplay &&
> +		    m->vdisplay == m_pref->vdisplay &&
> +		    highest_refresh < current_refresh) {
> +			highest_refresh = current_refresh;
> +			m_pref = m;
> +		}
> +	}
> +
> +	aconnector->freesync_vid_base = *m_pref;
> +	return m_pref;
> +}
> +
> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
> +				   struct amdgpu_dm_connector *aconnector) {
> +	struct drm_display_mode *high_mode;
> +	int timing_diff;
> +
> +	high_mode = get_highest_refresh_rate_mode(aconnector, false);
> +	if (!high_mode || !mode)
> +		return false;
> +
> +	timing_diff = high_mode->vtotal - mode->vtotal;
> +
> +	if (high_mode->clock == 0 || high_mode->clock != mode->clock ||
> +	    high_mode->hdisplay != mode->hdisplay ||
> +	    high_mode->vdisplay != mode->vdisplay ||
> +	    high_mode->hsync_start != mode->hsync_start ||
> +	    high_mode->hsync_end != mode->hsync_end ||
> +	    high_mode->htotal != mode->htotal ||
> +	    high_mode->hskew != mode->hskew ||
> +	    high_mode->vscan != mode->vscan ||
> +	    high_mode->vsync_start - mode->vsync_start != timing_diff ||
> +	    high_mode->vsync_end - mode->vsync_end != timing_diff)
> +		return false;
> +	else
> +		return true;
> +}
> +
>   static struct dc_stream_state *
>   create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		       const struct drm_display_mode *drm_mode, @@ -5345,8 
> +5436,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		dm_state ? &dm_state->base : NULL;
>   	struct dc_stream_state *stream = NULL;
>   	struct drm_display_mode mode = *drm_mode;
> +	struct drm_display_mode saved_mode;
> +	struct drm_display_mode *freesync_mode = NULL;
>   	bool native_mode_found = false;
> -	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
> +	bool recalculate_timing = dm_state ? (dm_state->scaling != RMX_OFF) 
> +: false;
>   	int mode_refresh;
>   	int preferred_refresh = 0;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> @@ -5354,6 +5447,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	uint32_t link_bandwidth_kbps;
>   #endif
>   	struct dc_sink *sink = NULL;
> +
> +	memset(&saved_mode, 0, sizeof(saved_mode));
> +
>   	if (aconnector == NULL) {
>   		DRM_ERROR("aconnector is NULL!\n");
>   		return stream;
> @@ -5406,25 +5502,38 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>   	} else {
> -		decide_crtc_timing_for_drm_display_mode(
> +		recalculate_timing |= amdgpu_freesync_vid_mode &&
> +				 is_freesync_video_mode(&mode, aconnector);
> +		if (recalculate_timing) {
> +			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
> +			saved_mode = mode;
> +			mode = *freesync_mode;
> +		} else {
> +			decide_crtc_timing_for_drm_display_mode(
>   				&mode, preferred_mode,
>   				dm_state ? (dm_state->scaling != RMX_OFF) : false);
> +		}
> +
>   		preferred_refresh = drm_mode_vrefresh(preferred_mode);
>   	}
>   
> -	if (!dm_state)
> +	if (recalculate_timing)
> +		drm_mode_set_crtcinfo(&saved_mode, 0);
> +	else
>   		drm_mode_set_crtcinfo(&mode, 0);
>   
> -	/*
> +       /*
>   	* If scaling is enabled and refresh rate didn't change
>   	* we copy the vic and polarities of the old timings
>   	*/
> -	if (!scale || mode_refresh != preferred_refresh)
> -		fill_stream_properties_from_drm_display_mode(stream,
> -			&mode, &aconnector->base, con_state, NULL, requested_bpc);
> +	if (!recalculate_timing || mode_refresh != preferred_refresh)
> +		fill_stream_properties_from_drm_display_mode(
> +			stream, &mode, &aconnector->base, con_state, NULL,
> +			requested_bpc);
>   	else
> -		fill_stream_properties_from_drm_display_mode(stream,
> -			&mode, &aconnector->base, con_state, old_stream, requested_bpc);
> +		fill_stream_properties_from_drm_display_mode(
> +			stream, &mode, &aconnector->base, con_state, old_stream,
> +			requested_bpc);
>   
>   	stream->timing.flags.DSC = 0;
>   
> @@ -7160,6 +7269,107 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>   	}
>   }
>   
> +static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
> +			      struct drm_display_mode *mode) {
> +	struct drm_display_mode *m;
> +
> +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> +		if (drm_mode_equal(m, mode))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static uint add_fs_modes(struct amdgpu_dm_connector *aconnector) {
> +	const struct drm_display_mode *m;
> +	struct drm_display_mode *new_mode;
> +	uint i;
> +	uint32_t new_modes_count = 0;
> +
> +	/* Standard FPS values
> +	 *
> +	 * 23.976   - TV/NTSC
> +	 * 24 	    - Cinema
> +	 * 25 	    - TV/PAL
> +	 * 29.97    - TV/NTSC
> +	 * 30 	    - TV/NTSC
> +	 * 48 	    - Cinema HFR
> +	 * 50 	    - TV/PAL
> +	 * 60 	    - Commonly used
> +	 * 48,72,96 - Multiples of 24
> +	 */
> +	const uint32_t common_rates[] = { 23976, 24000, 25000, 29970, 30000,
> +					 48000, 50000, 60000, 72000, 96000 };
> +
> +	/*
> +	 * Find mode with highest refresh rate with the same resolution
> +	 * as the preferred mode. Some monitors report a preferred mode
> +	 * with lower resolution than the highest refresh rate supported.
> +	 */
> +
> +	m = get_highest_refresh_rate_mode(aconnector, true);
> +	if (!m)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
> +		uint64_t target_vtotal, target_vtotal_diff;
> +		uint64_t num, den;
> +
> +		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
> +			continue;
> +
> +		if (common_rates[i] < aconnector->min_vfreq * 1000 ||
> +		    common_rates[i] > aconnector->max_vfreq * 1000)
> +			continue;
> +
> +		num = (unsigned long long)m->clock * 1000 * 1000;
> +		den = common_rates[i] * (unsigned long long)m->htotal;
> +		target_vtotal = div_u64(num, den);
> +		target_vtotal_diff = target_vtotal - m->vtotal;
> +
> +		/* Check for illegal modes */
> +		if (m->vsync_start + target_vtotal_diff < m->vdisplay ||
> +		    m->vsync_end + target_vtotal_diff < m->vsync_start ||
> +		    m->vtotal + target_vtotal_diff < m->vsync_end)
> +			continue;
> +
> +		new_mode = drm_mode_duplicate(aconnector->base.dev, m);
> +		if (!new_mode)
> +			goto out;
> +
> +		new_mode->vtotal += (u16)target_vtotal_diff;
> +		new_mode->vsync_start += (u16)target_vtotal_diff;
> +		new_mode->vsync_end += (u16)target_vtotal_diff;
> +		new_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
> +		new_mode->type |= DRM_MODE_TYPE_DRIVER;
> +
> +		if (!is_duplicate_mode(aconnector, new_mode)) {
> +			drm_mode_probed_add(&aconnector->base, new_mode);
> +			new_modes_count += 1;
> +		} else
> +			drm_mode_destroy(aconnector->base.dev, new_mode);
> +	}
> + out:
> +	return new_modes_count;
> +}
> +
> +static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
> +						   struct edid *edid)
> +{
> +	struct amdgpu_dm_connector *amdgpu_dm_connector =
> +		to_amdgpu_dm_connector(connector);
> +
> +	if (!(amdgpu_freesync_vid_mode && edid))
> +		return;
> +	
> +	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
> +		amdgpu_dm_connector->num_modes +=
> +			add_fs_modes(amdgpu_dm_connector);
> +}
> +
>   static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector = @@ -7175,6 
> +7385,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   	} else {
>   		amdgpu_dm_connector_ddc_get_modes(connector, edid);
>   		amdgpu_dm_connector_add_common_modes(encoder, connector);
> +		amdgpu_dm_connector_add_freesync_modes(connector, edid);
>   	}
>   	amdgpu_dm_fbc_init(connector);
>   
> @@ -7847,9 +8058,22 @@ static void update_stream_irq_parameters(
>   	if (new_crtc_state->vrr_supported &&
>   	    config.min_refresh_in_uhz &&
>   	    config.max_refresh_in_uhz) {
> -		config.state = new_crtc_state->base.vrr_enabled ?
> -			VRR_STATE_ACTIVE_VARIABLE :
> -			VRR_STATE_INACTIVE;
> +		/*
> +		 * if freesync compatible mode was set, config.state will be set
> +		 * in atomic check
> +		 */
> +		if (config.state == VRR_STATE_ACTIVE_FIXED && config.fixed_refresh_in_uhz &&
> +		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
> +		     new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED)) {
> +			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
> +			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
> +			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
> +			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
> +		} else {
> +			config.state = new_crtc_state->base.vrr_enabled ?
> +						     VRR_STATE_ACTIVE_VARIABLE :
> +						     VRR_STATE_INACTIVE;
> +		}
>   	} else {
>   		config.state = VRR_STATE_UNSUPPORTED;
>   	}
> @@ -8170,8 +8394,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		 * re-adjust the min/max bounds now that DC doesn't handle this
>   		 * as part of commit.
>   		 */
> -		if (amdgpu_dm_vrr_active(dm_old_crtc_state) !=
> -		    amdgpu_dm_vrr_active(acrtc_state)) {
> +		if (is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
>   			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>   			dc_stream_adjust_vmin_vmax(
>   				dm->dc, acrtc_state->stream,
> @@ -8456,6 +8679,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   			/* i.e. reset mode */
>   			if (dm_old_crtc_state->stream)
>   				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
> +
>   			mode_set_reset_required = true;
>   		}
>   	} /* for_each_crtc_in_state() */
> @@ -8866,6 +9090,7 @@ static void get_freesync_config_for_crtc(
>   			to_amdgpu_dm_connector(new_con_state->base.connector);
>   	struct drm_display_mode *mode = &new_crtc_state->base.mode;
>   	int vrefresh = drm_mode_vrefresh(mode);
> +	bool fs_vid_mode = false;
>   
>   	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
>   					vrefresh >= aconnector->min_vfreq && @@ -8873,17 +9098,24 @@ 
> static void get_freesync_config_for_crtc(
>   
>   	if (new_crtc_state->vrr_supported) {
>   		new_crtc_state->stream->ignore_msa_timing_param = true;
> -		config.state = new_crtc_state->base.vrr_enabled ?
> -				VRR_STATE_ACTIVE_VARIABLE :
> -				VRR_STATE_INACTIVE;
> -		config.min_refresh_in_uhz =
> -				aconnector->min_vfreq * 1000000;
> -		config.max_refresh_in_uhz =
> -				aconnector->max_vfreq * 1000000;
> +		fs_vid_mode = new_crtc_state->freesync_config.state == 
> +VRR_STATE_ACTIVE_FIXED;
> +
> +		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
> +		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
>   		config.vsif_supported = true;
>   		config.btr = true;
> -	}
>   
> +		if (fs_vid_mode) {
> +			config.state = VRR_STATE_ACTIVE_FIXED;
> +			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
> +			goto out;
> +		} else if (new_crtc_state->base.vrr_enabled) {
> +			config.state = VRR_STATE_ACTIVE_VARIABLE;
> +		} else {
> +			config.state = VRR_STATE_INACTIVE;
> +		}
> +	}
> +out:
>   	new_crtc_state->freesync_config = config;
>   }
>   
> @@ -8896,6 +9128,50 @@ static void reset_freesync_config_for_crtc(
>   	       sizeof(new_crtc_state->vrr_infopacket));
>   }
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state) {
> +	struct drm_display_mode old_mode, new_mode;
> +
> +	if (!old_crtc_state || !new_crtc_state)
> +		return false;
> +
> +	old_mode = old_crtc_state->mode;
> +	new_mode = new_crtc_state->mode;
> +
> +	if (old_mode.clock       == new_mode.clock &&
> +	    old_mode.hdisplay    == new_mode.hdisplay &&
> +	    old_mode.vdisplay    == new_mode.vdisplay &&
> +	    old_mode.htotal      == new_mode.htotal &&
> +	    old_mode.vtotal      != new_mode.vtotal &&
> +	    old_mode.hsync_start == new_mode.hsync_start &&
> +	    old_mode.vsync_start != new_mode.vsync_start &&
> +	    old_mode.hsync_end   == new_mode.hsync_end &&
> +	    old_mode.vsync_end   != new_mode.vsync_end &&
> +	    old_mode.hskew       == new_mode.hskew &&
> +	    old_mode.vscan       == new_mode.vscan &&
> +	    (old_mode.vsync_end - old_mode.vsync_start) ==
> +	    (new_mode.vsync_end - new_mode.vsync_start))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
> +	uint64_t num, den, res;
> +	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
> +
> +	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
> +
> +	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
> +	den = (unsigned long long)new_crtc_state->mode.htotal *
> +	      (unsigned long long)new_crtc_state->mode.vtotal;
> +
> +	res = div_u64(num, den);
> +	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res; }
> +
>   static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   				struct drm_atomic_state *state,
>   				struct drm_crtc *crtc,
> @@ -8986,6 +9262,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		 * TODO: Refactor this function to allow this check to work
>   		 * in all conditions.
>   		 */
> +		if (amdgpu_freesync_vid_mode &&
> +		    dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
> +			goto skip_modeset;
> +
>   		if (dm_new_crtc_state->stream &&
>   		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
>   		    dc_is_stream_scaling_unchanged(new_stream, 
> dm_old_crtc_state->stream)) { @@ -9017,6 +9298,24 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		if (!dm_old_crtc_state->stream)
>   			goto skip_modeset;
>   
> +		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state,
> +						     old_crtc_state)) {
> +			new_crtc_state->mode_changed = false;
> +			DRM_DEBUG_DRIVER(
> +				"Mode change not required for front porch change, "
> +				"setting mode_changed to %d",
> +				new_crtc_state->mode_changed);
> +
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +
> +			goto skip_modeset;
> +		} else if (amdgpu_freesync_vid_mode && aconnector &&
> +			   is_freesync_video_mode(&new_crtc_state->mode,
> +						  aconnector)) {
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +		}
> +
>   		ret = dm_atomic_get_state(state, &dm_state);
>   		if (ret)
>   			goto fail;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2c9eed78f6df..face69078d71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -465,6 +465,8 @@ struct amdgpu_dm_connector {
>   #endif
>   	bool force_yuv420_output;
>   	struct dsc_preferred_settings dsc_settings;
> +	/* Cached display modes */
> +	struct drm_display_mode freesync_vid_base;
>   };
>   
>   #define to_amdgpu_dm_connector(x) container_of(x, struct 
> amdgpu_dm_connector, base)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
