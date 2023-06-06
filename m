Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DC1C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 14:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C3410E35E;
	Tue,  6 Jun 2023 14:26:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6294B10E35E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 14:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsDa5cPz3PcAA3aqSOBrTsIIE/A2JH2vDqhuJG82P6FFHy5TsKWmdMzlTLN9jIM6HIMrifKqiEjefgJdsNrczO9UN5GRLQTUtKtZ5e6bE2EoP7GnrayxcTO/knM5BqTOK0QFjHypWY8Px/fxJjksSvFI+Aua2DCkunwjF0EsYZ5Rbe4iWcQOYaOUB/UpEP9f99P+mZ3hUThecM476WZbCf9SyHYYLNeggSb/8u3Ab+yTQu/ZD9Qx/Sz29K2/7JFMC0tYltcLPyh2HIUNvTSUZ6ROwYFoa5QkUjYsA6tKVcxc2oByzFIoYUX10zvd88lxUQv1IyTN6J4QRB3zV0TdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CSpF6Q1WQFUTx6CPrkMomVqIbhBoq5mfsHVRKHS14o=;
 b=l1pewSHEQ6qYy40ZN8n9H6ZWuNzcsSPZDVkDTe9bDbEgf8KsWRZMzwMgvNEbJpgBxgIuuGEcS4gXgXmpPCerxIJekZAlpPGyKBOcDLsOAxl0WqMjbdBRtneCtSQjvqTIL1sNe+eRwmWygyK9EgqRW4WqtJpGnNPrNHiOjbwNwxSwBbBkofwlHwSQMFcigocdTHWC6ZEfr4+Yv+in5Tl7+BBH3ZOP9Tl94FCTY2seRTOESquWgWM+C8MiOMtaMW/egdWCZZL1+M3Nu1qjUM7JKUvsKrL4MTc4cX0qmF4kGXGnW11I6RArR8z+teKaWCwzfA5KR+pPMA7BCBvz4rS+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CSpF6Q1WQFUTx6CPrkMomVqIbhBoq5mfsHVRKHS14o=;
 b=t3gqdvCVmmk+aHttTvNEpqEZ+er7+HJMRyhYoj4udlrb5sVXota4ekyURh16jePAU202FqAg9xXgaMplWG+l41QW2TtwtWs3Vyy56XqcettOL7ATisn7CO4eSH6gnokzEQ4jSELn3mHlfVLYxvkoUSfj52PO+7iEytc3PHBM35g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 14:26:56 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6433.024; Tue, 6 Jun 2023
 14:26:56 +0000
Message-ID: <fe199dfb-518d-6618-f1ec-f00679a6012a@amd.com>
Date: Tue, 6 Jun 2023 10:26:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_drm/amd/display=3a_Fix_unused_variable_?=
 =?UTF-8?B?4oCYc2hvdWxkX2xvY2tfYWxsX3BpcGVz4oCZ?=
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20230606120645.2603967-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230606120645.2603967-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::15) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 15659c10-1979-406b-3251-08db669a147e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ6X07eUddBuR6y1t+nfFX7di0NWkuvNkx2kbymiD4vEeKQkNuKSZF7dAzz2tzDLRGJCFPKsl9l38pNqSiGSPyoLf54Ymaa3eX7U4AOZpTopwVPYpbjxfHykMR+JAI97cu8hQwdSkc0s4gEn6CqUS55KvT9vSymhFCsBmWGaWERZwuegNjz0Oki28UY47ozY+J7RNH/Z6nzQFxjI5Scw8EJ9LGWCs5HBemcPiF37TgH0aug55PolexQ5ZUk6zs0BDFC8zvOEl+PBpI1h5xPTxt1VSxE6T9zCTUjVkd/N01wgbNxMSV7W2yDlvGgSK8OCSYd8l+QpX/sUv/OTTmASnzFEkxssYuX2+YeSu9sAIfpOyBj/z8LW2ZTcy2LUwmDtGSdUyedeQpE3elZ2HQKfY9pmZwZPIota8dN0mjWVmivliHm9YWgIC1pMRKRGEGQ+A4kaol9h8sjW667TvhQAsWbAr6FBC+C65eyFoxBWcQrt1XFLf6DjSjf22erPMeAlKc5H6G5pjIo7bm1s9aC1VQMNt2UUknTI8prOeC2dyqpK4MRnBqzm5FQjXzp8oMDciHKpHJdpVKuUyFtaq5uh5p7EE2tQdjonTZPhmmxmpymVRua+9Jo3dRUrKZH/KLC5M/tv8thAXiJ4T8hbIWnqWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(2906002)(83380400001)(2616005)(86362001)(36756003)(31696002)(38100700002)(6486002)(41300700001)(6666004)(5660300002)(316002)(8936002)(110136005)(478600001)(66556008)(66946007)(66476007)(31686004)(4326008)(6512007)(53546011)(6506007)(6636002)(26005)(186003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHB3MElxVGJXZXE2eWxEQU1Vd285aGhUdkcyL1pjY0lKWHkwOVRlRS9UcXFt?=
 =?utf-8?B?T29wVklOTURKSERiSUc1S2l5N2RIQlIrcHF1QmgvSW9nVWtOZDFWT2hvTTFu?=
 =?utf-8?B?WkRFdEUralZIQSt3Qk5BNDdPcFI3QnlITlExY2V0YWpaSitOZU1YSDNGOHFU?=
 =?utf-8?B?SHkyVFFmWm42NnFaZmQ3TjgxekYyemhSMEZnQTA4cVhPcVluMi9ZUUE0N3VL?=
 =?utf-8?B?OVZGd1JkR29sMzlvcFR6Z2tLYlR4SDUzZG9tZmN5RmNrQUM3YWg1eFB2T3ZU?=
 =?utf-8?B?cUJqaURuZ3QyUlJjNjVCejBKem1VUitzN0lxYkVMWGJKdHJDTDB2QXdmUjkz?=
 =?utf-8?B?cWloOFJHMnVNNHZzbTF4ckg3YVd1SDNKcElEajdLckFnUi9XcWdpNGdYK3NO?=
 =?utf-8?B?MTVKbDgydnQzU3ZSazFSV1EzNW5MdUlqQ2R4YzExd1BlZlZyVmFEK2w5S09n?=
 =?utf-8?B?eldJOVlEWDhmQXdWT0Npb2RUbnN4RzRSenEwYVpUQmV6MWZGWmN6aHlEY2N2?=
 =?utf-8?B?NUpQU256K3pUOUJVN3NmVlhEaFBwZUdRWkQ4S3ZId0VwT3hsY0JMSjdZSHpW?=
 =?utf-8?B?c0N5YnhEWFMwMFhQY21mWDBwRng1dkJIdFBqUVZUM2c2VWtHNFVVYWJ5QXlK?=
 =?utf-8?B?YVp0NllBM1VoRE1DSTdTclYwNHFEdkZqMVdMdE9nWUZTRlBqMmFDc21XRFhl?=
 =?utf-8?B?T2NwMkNIUDkraTJUZkwzUlhOdThvbmJNODFHcG42R0x4UU5Nd0hJZVZDR1ZB?=
 =?utf-8?B?dDNWZkkyMFRQNktYRG9TTlJETTgvbnlWKytQc3FXdWJZcWRDdW14d0RrVXVO?=
 =?utf-8?B?TkUrVU9pemxpY3ZaRWh3emNYbUJ3WUgzcHRNRVdmVFBGK3FJM0ZVYWIxY1FX?=
 =?utf-8?B?U2pVVGw5MXpxWnRScEpzQUdReWRuVmZtVVFhbDFDVG5UZ0U1V1h4aVRIekdS?=
 =?utf-8?B?MzJQK3pDTkNoNzFycnNPMER4a1M2NGNUeE1JaEpDbnNxd3huKzZIbnNCS2RR?=
 =?utf-8?B?eHB0M0pSUWxwSUwyYWpyeTlTOThwQkt6TWpMK0g5SjFLZVVDeWprc2pBaHRW?=
 =?utf-8?B?L0JnMFVkek1xK2xHRjNIV0JiSzhJYldGS042dm50NjFMR2NSemtWY2JpL21t?=
 =?utf-8?B?bTZwVjVobzRPclA4ZFZXaVR5Z2lUcXg1WWVoSjBiTS9yVFNUdEFSK3RQd3R2?=
 =?utf-8?B?Y1lhL3RBL2xTYkpyVXUxRzl1T1hCSGp5YWpualVKMkphUU9JaDRTS1FhTzBp?=
 =?utf-8?B?NG1YQ3lmQ3I0VWpoSW5UYWhJR2VWaXpsNXJVUU1WdG5DZDdKelM2dW55N3hp?=
 =?utf-8?B?cHFMTGl6WVRkd1VxMTVUT1hHQmRqRVRha3IyU3RvY2xXRzhkSHFRdWRrdngy?=
 =?utf-8?B?OTNSWjR3VStRVHNXYWRZN3JXM2g3S1lBd2IrZ2VhU0t4azFkdi8yL0ltMGQr?=
 =?utf-8?B?UXZoSmJOMHY3dGF2SVpSWnBTMzZQZmh3UFROdTBhY2tJL1pyRVBSSld0L1lD?=
 =?utf-8?B?SFhEUmRKOXBpNjNDeWRaaE51aHhtOS9yMlhhdlJYbVdmdERKNDVoelJxcmJV?=
 =?utf-8?B?U1BLL1BTb25DUjNNMnRtMjRMaHllZVFHSEN2a1hUOERuWGtJTWp5V0FLdXQ4?=
 =?utf-8?B?NUpyMjl4ZnJkZWw1VU8xTnhhNS9vQ3FLbGV5bDBZU3dwSjhvMmxvYmh4OWNm?=
 =?utf-8?B?bThJQ3lxR1orMTJ0WUxjdm0rblkrUk1NN3dscVJKZldmV1J5RjY2TStWOWYw?=
 =?utf-8?B?TlBVWGxPZHZ5UzgyNGFxeWVnVURvZU4vb3NkaDFLaDE3R21CYk1OclRQWk1Z?=
 =?utf-8?B?Tk1GR0oxOGZjcHU2RTFKTVJobTlJTXNaU0haMUpONTY2cC8vMTNmSktsZlIy?=
 =?utf-8?B?NVVweUpweXYySGZheFdSUEkrWFJqdmdJWmJUUzRrTGk4cW1zYWRJUTAwMW1V?=
 =?utf-8?B?aFo2MGE5dEZYU0ZMY0tDcjRGRlQwemUxaXltY2lIWkcwenlSVEdFMDVlWkxZ?=
 =?utf-8?B?aDBpK0w3SzQwNnBpdlBvbnRYb0ZIS1hEWG8zRTR5dkVXSk5EK0ZiTHJCYXlD?=
 =?utf-8?B?T1VBNzg3ekI3V0VjRmFpdmw0QnlFVVhSd3UvU0EwdlhVMjN5MDZWajZkNFBP?=
 =?utf-8?Q?4FK8Ez9CJUidMJ2oEuRQnujyR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15659c10-1979-406b-3251-08db669a147e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:26:56.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICUltU5bFnvQd426rQo9AP9M1e/Y5zVXywUS2N/tCGg69uERKDZrKnbvEDdZb39utBQPBE9xz0EqnEtsk52G6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/6/23 08:06, Srinivasan Shanmugam wrote:
> Fix below compilation error:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3524:7: error: unused variable 'should_lock_all_pipes' [-Werror,-Wunused-variable]
>          bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 172bae983425..5e18fc0c79d6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3521,7 +3521,6 @@ static void commit_planes_for_stream_fast(struct dc *dc,
>   {
>   	int i, j;
>   	struct pipe_ctx *top_pipe_to_program = NULL;
> -	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
>   	dc_z10_restore(dc);
>   
>   	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
Hamza

