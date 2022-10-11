Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664E3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 15:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C29A10E3B4;
	Tue, 11 Oct 2022 15:23:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D65E10E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 15:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEbZctNAXn0b0NQ5TnrRUS82wcfz9Lc9Cpsu3c4JxQhGObWyU5DSHv90r8/ACM/xTuWhFrgTn2FPyFASjDWSr6JocuEgaukyQzZcBVeqZnJw5kKiUcV0ewachT7jaEGEqEPIgcWSFgewwbHRp5qT527O8Sl27ssez3JElFDPTrTmh9sG0bG5YTvIS8R4yNd592gKh6hsGrwoDuiG55EwF9kQqy8IbQuqENEr++cFq9SChLYVS+gO7OwmYz/Dnxo76NfSCjsGrmOwVD/UBxb7H0obIKpjZDy5wOcPFiRhG/TNkvPJNWv70u7iZSw9dxQ4Oak6/1fGuPS4HWZsAV6V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psu/nMShOIpOwaxWAzPvqunQkGU4K6n2/ktkpXn50WY=;
 b=KwcwYNOA9AmehAhjEAgoJxlLn1ln+58t6CFL/uO0cYlWyDpstGtDxSCUXfzanA2i6T+zxJmbYuHXTwz6QM9K7ZtqVhDvHSndzkqTZUrMrwR1D92NlYjLBpZft6qzEMnxkHg+eFRVxwVe2e5L6YEfZ9hAhKz5qNIEcHNFzbZSZDBpvbN0C+berT/8KBuJs9cNeXJ2cPFvKKECXmaDsLX3B6fB+Ic3eKV1pYxzhSv9UG9skxlnZXQqxAjjPrwVgokHKZfoxMOVBJuk7TLD1EjQIsKQ1Xz7b1461tsON6C8qDSDxs1xo7PpQCXWYH6t9VNz/geJj+U9ZLtfnsiOhMhhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psu/nMShOIpOwaxWAzPvqunQkGU4K6n2/ktkpXn50WY=;
 b=E5tcKPZ1JmaN4VzG72BmL/UN/urGW1wvL43M+Se+vPSMLVcCb8nUIY/WUP98rzFRAHT4rDJlDQyasW6/Qe9+F6U6HVcETXjyr95VUWGXwL5748KhkZtFA8S57fwxUJ9CXOvFy0bSWwu14u3e47Wi/65HNLVrr/wFEjIiIHfimNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 15:22:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 15:22:56 +0000
Message-ID: <0f3d8e6f-7b0c-c428-c84f-aa1a51363745@amd.com>
Date: Tue, 11 Oct 2022 11:22:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amd/display: make virtual_disable_link_output static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221010144158.4025735-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221010144158.4025735-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee1ddbc-8d24-49e4-0724-08daab9c792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c4f6yl09Erq5EpLHPm4FzaNiP/swplXZA7CiX5lxq4WnJaR++USoT7dB+l7mBzGW0ochfvGn7MEPFJse+y2/MoIE7oiEV1jL0WmJpFfFZ9MQCmAgv3whguD3gDsu7ZyzB8MDgRuJ7T+q5vTwNxBTJ0UOsLUDSX25MrjPMwbb2mRW11K7zPem9lmNkeEf5FdpFUx6TO706KHRgPT2kEXuFe4sQDEd8aI6Rk/vkl9RqrTkuupFA1xQNW0Pzoee4lsGjZGL+X7BWe7YT2ygNojidT+jmTZtp9LWVqw873jNUYwj8Oy1xJPjtSK0wDDtcRlW6ZThDgXrUI+RfAC+nK/EIVFU5ixtPZw2EqmlXze+iNIsAIkRzaoJYeDEwxQlEszu5sXgwIqXB1EKKrHdBdtkXXuRpyhJZ08c9U2HJXgHJJTM1ZsnQrD71P+LoUzymnrLS/NXqzPG4PbbIUvvoz7zfSCVT6DnKzba4N/dLwzMKabdg2zzPJmNd0kLv+KDUSVwZsWfyMHcA2x6x85Fw6/9zNDSGd2l2pznq4YlHwL15fxlVpdif+BZxhM61nkcafV5E/1IXHv7+dRxAKidsGezZECDr+Rc7M6j0TDTbG0mlG2/OaFjZwdjD3k1zmKzJRIpfbOcp6NDvXrh14vl5zMy1Z0pr/gWR4VMTP53IblsirmdqhNa6kc62lN2v563gnHp4CIeOcFJEGxC1VCRG5x2rs7ENT8tdv0GLW1I4PYCHNRBYf87/k/9e8ePXHtbD6rzfDDtCrgMIYcT/o7SU0Lrim3NIl7SgXGNl7A5QNe7F4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(6486002)(478600001)(2906002)(4001150100001)(6512007)(26005)(2616005)(6506007)(6666004)(186003)(53546011)(66946007)(86362001)(66476007)(31696002)(66556008)(316002)(8676002)(5660300002)(8936002)(44832011)(38100700002)(83380400001)(4744005)(41300700001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1yMW5vTTIvdTRBTkNqTUY4bEdYNFBNcDJqcUJmNXlkKzA1dVVkQXhBRXZk?=
 =?utf-8?B?UmJkZ0d2SVpGK09uU2Q5RlpwejB6VXpwVGdhZjI0Qm01dUg3UGlLenJFYkp3?=
 =?utf-8?B?Z2J4QlZ6WitCanJ6Zzk0c3JIQUhWbndZUDZ3Q1BFcHA2RHpJc216bmlRVE5o?=
 =?utf-8?B?cVgyK3N2Ym9OMFAzb0xlR29HcmIzd1FQdzhHbyt3cjFUQThQL0Q3eExhT1BP?=
 =?utf-8?B?dE1Xb3ZITHVSbTcrQ3pHYzRFem1Leno5emo1VjBkQjFIVXlQK1pPaUh2ZEI5?=
 =?utf-8?B?STc4TWQ2VWNLaStrV3RFZzlNSjhLNno0Z3EwdDhyRkw5R09lYXcyclNFd25r?=
 =?utf-8?B?a1FEUEhMWDVyZmJEby9KRWdZUG0rVHRabzhDNFNab2h0NmFkTCtiUXFNclI2?=
 =?utf-8?B?YmZXSVErdjFXaEZQSEFCZWx4UTNWWGNMeHRrRk45cXFsaW1wVFpOaXNCbkNF?=
 =?utf-8?B?UTRKdmVNUzRaMXJabzN3aWI2WmtqZGRTMW9RbXZCR0JTRjBCRjBPbHBUaCtj?=
 =?utf-8?B?N0hPZUtkN0NEUnhycFN3b0xGNlNaMkZLSjFCZ3dxaDlpbEJtSDlxb3BXb3pq?=
 =?utf-8?B?VUxSWDIyL1kvaFdLSVhHbHBrVDJvNHJ2SzVvUG5rZnQ4dGJOZ3JubHZWaUov?=
 =?utf-8?B?azdQdTNnaHBzQ2tDU0VHZEhzOVVYWWRMU1RKeE9TVFlJaHFQdXV1SEdyY2dO?=
 =?utf-8?B?Y1hsc3dCVC9XT0xkbllzd1lqdmtzOU1Ydk1URW05RFhzYnQ0UWV2V3VUK3JO?=
 =?utf-8?B?WnpScExhT1dIQWxpdFJ3MWJLVC9JR05DM090MnVqeDZ6WENrV0tHNUplOXZs?=
 =?utf-8?B?bmFPV01CbHQzZFpPZGFiMkFRNElxTWp0YSs3SklKZ2MrS3Fhc2JFcFNObkxS?=
 =?utf-8?B?STAxb0hqaC9NdjNOWERzcWxRK1JZeXJGTnhBOUdycVo5bUtWelZ4ay9vdmZq?=
 =?utf-8?B?eElUMTdkeGFZREJJNkJTcmVMc1VHdjRScGowc1MvNHlXQmRBZGhqR0dpTWVU?=
 =?utf-8?B?VWtGNzBLUVBHSnYrNytGRGZFZjM2OEVSYTBUa2x1dEZQNTlOTXMyWEk3WkhQ?=
 =?utf-8?B?Mk1jUitvVDBHQVpUMCszQ0FDbFRMYzFzNGNnYnJkZ0lBMlhGcjY1WUpZMlIy?=
 =?utf-8?B?dEk1SE1EeWUwTG9DZWJnN2h1UkV5RHUrT0NEb2ovdU0yMmdwNHpYVWhoaFBo?=
 =?utf-8?B?Wmd6a20zeExxKzZsemtrM1BucmRZdWtYL2tianBwMHhnTmpXQ05iQlJFaUxH?=
 =?utf-8?B?eU0zRWcrSWxZUzJyTk1PRzNoVE9EVWcxNk14LzY4S0pvZU5lTEdtL0RsUHpP?=
 =?utf-8?B?V1RKdUZVYmRuZVhaTE9rQzBhU1NpMXFvZzZScEc3VkVTSFVrSXUzeE1TS0VL?=
 =?utf-8?B?TTR0SHhpQ00yT1p4cUQwRDFEZk9qN0YvMmt0U1l6ZHRKemVQMzhDL0ZrMHRj?=
 =?utf-8?B?L2gzT1plUCtlWXNLV0RSbUtNbjF5S29jM0YzSFp3RmExcng0ck1LVE9HOEgr?=
 =?utf-8?B?U3gwMWFTdUpRR0dKZFJ2WUFOR0tlUGNQYTJPMWhOVHljWjN6SjAvdU0wbXBz?=
 =?utf-8?B?UjJSbldlajd6YjQ0WUtUMVJobEZMNUw3SjdSY2VOV2dEaHYzZHRtVlVWanZk?=
 =?utf-8?B?T1dIL3NrdVBBU0pBKytyTVJFelJuWWlUU2xRWWRFWFkzdkNZYnZDS3JVUElI?=
 =?utf-8?B?TjlaVFFRWnA0TkhGUDhhZTgxVTBCL2tYWjM5RFFvdDRub1p5ZEhacVNaQ1Vz?=
 =?utf-8?B?eWhQcEltWWg4bFRkTFJHd1g1bStoNUZZdWhtd1FuaW12THRNbW9XdmJxYVJY?=
 =?utf-8?B?N050bDl1QklqSW9mZThCbGtOb1Vrd2s4bUMxTzhvZXlCNTlPcVh3a2RUQlJt?=
 =?utf-8?B?M1BaSGFQbUQ4c1d0SksxNk9IZFptdHlpL25NZmwraGtjLzUySzZiaEc1NEYx?=
 =?utf-8?B?Z3hYSmV1QnFEMWRGL2RuUnE2c2daUG9vWmFtZElWVTdjenQwRTNTTUFqRW91?=
 =?utf-8?B?L3RaU2F2S3JJMlFzTkEyMDRhTi9vdmYyUWFhbGkrdk05N2hnc1VkQzhVQ1Jo?=
 =?utf-8?B?YmFiZ282c3FmR2FidGdhM0NScjcxcjBHc3V3YVdtNzJ0YVpnL0RUK2FDVDc2?=
 =?utf-8?Q?+1GTCYGdpZeGJ1Hj11LCZKDLp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee1ddbc-8d24-49e4-0724-08daab9c792b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:22:56.4644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjNGHb6zO5udjc6gr0f/fF1Z21bbf50YoJ79x4nQm++lhVR8+BaW/EPKryS7mnijGwxMw37WTLmU03wClJIyDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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

On 2022-10-10 10:41, Alex Deucher wrote:
> It's not used outside of virtual_link_hwss.c.  Fixes
> a -Wmissing-prototypes warning.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
> index 9522fe0b36c9..4f7f99156897 100644
> --- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
> +++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
> @@ -37,7 +37,7 @@ void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
>  {
>  }
>  
> -void virtual_disable_link_output(struct dc_link *link,
> +static void virtual_disable_link_output(struct dc_link *link,
>  	const struct link_resource *link_res,
>  	enum signal_type signal)
>  {

