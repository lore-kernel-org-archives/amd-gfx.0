Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4059EEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB17910E068;
	Fri, 23 Jun 2023 19:28:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF8A10E068
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE281Ne3uI7IX9IVbQzrap/C7/Kk8/I0wrzrlzStiDMzbNUJl9rCMdpLbTqf8jUAnG0f63Q6LJ7x0wtaL5sDD2guuIgjh8i1ZMDW3W7o2tNgYN2gLlg0UbS9KvAzmXf0JPSf0nwtBCq+HrQMkBav9Wt/46/ruU5nBGj5Gg33RF0HzjpaNeonbbmtPke0IzBxGs3Lb8F3WCk/1td20xSmg6P27FX8oMF64RL1Ub4Df000of1SJhCKAhuvteNAQbpUAmhR6hP0MVvus7s0XV3V4I8+zDABLb7S212Rr5Ubg2xcNTTANi4Ky4PnCXOYyKBYYB/O5gMdCzJsMQocmMZw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXCkkI1lipC6tzHyya2h+Hg21A+YRvXYUBiyt0/bsAY=;
 b=iqEud/8OYIRTEmPSbihKn90vheHE3z4OQyKqjkfm9unp7i7BNSI6HadpiAeCCk/cFMTpl+VVZ0sEpmq0vjL0aDOaj5jxdMV5/weLUdfcVM6SII3gzp+CC845dk/JuTOnWdc/zB4OuIo7jVCP2GxOAazJEYhLWuASYHxE/rNeuQXDz6ZhKAAcFQPgqX2zWF7GOwWSzbWBko+Lm5aaSLan+qttevk7o8HHwd44bjaTKqglW76nqYczz4Qt4vPXwFlPv2MJXgWX9QV2Z6L0nN0rpsxAV/zfGd0takAew9yDtNNLUaJgpox9VeKopnhbFkqGYGHlcT0Hy0BvCr1qsLZdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXCkkI1lipC6tzHyya2h+Hg21A+YRvXYUBiyt0/bsAY=;
 b=KPwPNm6wQ2Dsserb+bRrCwrfJr4f12aIlbMUWPtoHYlINQUgrUan+8mlgKwvclWmsgY/VpVZeO6fPg+jzkFmW4tktrPsaQgCVhr83iV0bw0CdmblGUpDf3NAom62BKNHnqZkjg3b1vJ97G1AKU69ed3VSFDi44E841WdAsl9x/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 19:27:56 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 19:27:56 +0000
Message-ID: <d4ccc590-4048-9e53-cd36-e48b479ecdf9@amd.com>
Date: Fri, 23 Jun 2023 15:27:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] drm/amd/display: Correct `DMUB_FW_VERSION` macro
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230622182507.25531-1-mario.limonciello@amd.com>
 <20230622182507.25531-2-mario.limonciello@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230622182507.25531-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:408:fc::27) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: d270be58-4769-4d37-6e71-08db741ff2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDleCd0kMALRWt74KbnpA/TOsxcaHgoTMwy73id1QElWIxRtT54G8Q4s5a/Yi8Mrxyy7l79inTR9uC169YmB6HGfoZRoaeI5/I3uEKm8oCEU21cJmFim6fQrfHKzGgCWIMMILTQZCFI1S/1i26VjgOAFu41j4E+I0QzLDlMeF7a+yJsoOsj7V3Vzws/GPudAQIMHUcIK5T8Ao2xu6MrWROFbSolKn4RQRVzNvSpyxkcUr8epxqg13JKE0E8ybIG1P29GF6V22s0JXK8Cp9dUhuOWiBqgbTNoMKOiEeMh8lD6oHTxGimPzhtBht8O049oVCesCpMcLvaftbq5FbGL/6gmuslC99M8rH5TmVlZDzmwRLUgPpv6/gaw8/bRjnK3NkiEq78l8PNNLeHU8TwMN+LK0tfC+T8pNGYAq9LIVubXQVnEZrfdmvDDWz9KgJxsfn1tl6341yPZhrQYm2uooBHF8LI1U0Zt6SPB5lVLwBhf2PYhiQ9/ggz2GE1dPti6VNg36hL6ffslJnyVTxU2IKWDD0xD0Ik0THMhREw5FsoEjunj/boOmFoGR/betP1EVUOGUODo6tdrPvA8+cItUbjOCacaR4YbXwheXJeWECtsdwRLryRT49w4w+x5TTu1JFkbqltAz9C2Sc68qllUU82uYxRzVMOZBaSsH8wvxBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(478600001)(54906003)(4326008)(186003)(26005)(6486002)(6512007)(2906002)(8936002)(66556008)(66476007)(66946007)(41300700001)(8676002)(316002)(5660300002)(6506007)(53546011)(86362001)(31696002)(36756003)(83380400001)(2616005)(38100700002)(31686004)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE4xd0hVT2VuT0xHRVdpeEc4dk5GZ3JSZHBveHRhcGFGN21DQWZxZ3hTMStl?=
 =?utf-8?B?cGlIM2JvRExOZ2s4NVpvOUxxYWV5cVc2NnViWDJoeW1pK0VtMXZPOFp4T3dq?=
 =?utf-8?B?K2tCK2JNZ0wvUnUweEdFVkF6S3pEY25ZbFFMS1dpQzB6TEN5V2NkZVBkOUhP?=
 =?utf-8?B?M2daYm14QXZBRHRydCsvWnZKblFSWjZYK3NSYmVZVmNPYW82MG1QazhINVMy?=
 =?utf-8?B?RUlVWlpoQkhFOW9TNlBhWHRPNm5tOXZ0YlV0VDJxYy9hek4vQkIxTGlPNjBQ?=
 =?utf-8?B?bjBicUU3NTRRSmV0ajBCUnBuNE1vekpqTVZhWDJ4Q1g5cjFTeHNkTDFsUmlq?=
 =?utf-8?B?U1QxM0lNd3pSWUp5R2txN0lHQS9vRXV3M3ZoSEFDbkdDdndUbVFkQTc3amR4?=
 =?utf-8?B?YTBSS3NhR2FySGtoSE9xRmVGZG9Tdmp3WTZ1MVhxbDdiOXdldkdqUGdlSit0?=
 =?utf-8?B?SnV3QnBZVktqbXBVSU5McERTamZvTVNVMDYxTWFoaEZaZW9OOEVwa1h1bWx6?=
 =?utf-8?B?T0x6QmN2L1FKTmxBWU1INFl6bUdsR1M0VjduZlMySVV5bER6NVlWaUhKVldm?=
 =?utf-8?B?ekJ0RGd1RTFvMzJGd1NLWnZJOXV0WldDWkFnTGpNU1Q5VmZBdW1JVnhHbEJP?=
 =?utf-8?B?RHNkVjdta3VWdnM3VGN2NGs4QnFMVEJSVEY5bUN5MDExeFgwT0VBU1I0QkRu?=
 =?utf-8?B?cVJYNVAya0dCeFROUlJqVU1ndmx1YVhJc0pTR2h0azhXWHZ4bnZzQndERzNw?=
 =?utf-8?B?ZTdhYmhsVktKNWVnZi8xRkc4WWF2cmUwYmxmN1VSeWM0clRmSGhLVEdzN2hI?=
 =?utf-8?B?cWx3WkdncXQ4UDlRRXdoZjRRQ0dJbmo2aXlBYXBqWk5hRVpOWFdXbDVtVmpE?=
 =?utf-8?B?MzdsSG1QdEhwbU55Q1J0RENEK1N1aTIxUnZ0UloxeDQwaFBhLzFCbWdvWHgr?=
 =?utf-8?B?YjNueklVQTRYek04dkFqb3FxU0F1enBjYk5jOXMvWXdKbC9rdnBWV0pOM3lJ?=
 =?utf-8?B?VnpxUFJhNjVERkIwUE4ydHlNc09lby9jd1N2MWQ0UmIwdnFybUlIa2Fla2l3?=
 =?utf-8?B?cWdmVU5kVVBtTnFZTlYzQ1BBRkYyV2dMajE1ZGw4djNMWHRpV1VUTytCOWp3?=
 =?utf-8?B?V1VzKys4eUpzYTdrdXZMWTZjMnVLNzVhQjZhaEZFVnF5Z3pEMjZxK1Eyc3Nh?=
 =?utf-8?B?RXAvaDFpaWVlZmgzelQ0ZUJaRy8vVFNianlVVi9UTC9NUVBtNzNtaFRvck1V?=
 =?utf-8?B?RzlFWDlJWW5LTUM0RVN2clNoaG9IN2d0VTBhdld2ZElLOTY0WUgrTXd0Tm1V?=
 =?utf-8?B?ejRoMFpEKzJveE1MWEJERnRESkVveW96K3loSnZYenNCUVRnWWYwcUhGMWhE?=
 =?utf-8?B?ZEJXNzZiYkcvcjREaTNjMzFjV3NSVStpRnFDK3NWVjIvUkJZSml5UHFKTGpB?=
 =?utf-8?B?ejQyeTZhS0ZmVXVxazhDQ2dMYXRRbXkxcXdrK3lydTFsTCtHa1d6TllVb3Rj?=
 =?utf-8?B?SVdXSWR4VTVVV3Q5bVhNbUxvd0Z3UW9Sa0JEbjlzd0NFOEdzNWdWWEdRQWJF?=
 =?utf-8?B?eERCMWdEMHpUTVNWUnd6YmU1SWFTUE9rejMrbi9abVlicTNOdnBYOUhrbERP?=
 =?utf-8?B?ekNWQVV6bllRY3ZKNjFOOWl6RDl6b294R3h4Zy9tb1R2MDdGVW9BUGFOdXdQ?=
 =?utf-8?B?b2t4cXhhLzRuRHhEclE5RHFNVndEYTdySnVxSk5IS0R4ZEcxQUxOUDU0Mnpr?=
 =?utf-8?B?T1RmWG5Jc0dJUmN0cXIzV0lSUEZMbWxYcmVMSlVmRHIyR1grb0hoZWk0YWNa?=
 =?utf-8?B?d1pqQTNlbkVFMGpyam1WcVFUemtockxIRlhoUFBoekRlTDBVTlJWcWdzSFBL?=
 =?utf-8?B?anQySWZvT3hOTVJNaGNyNjZXTU52V1k2SVNQVE1pWjBHS3pBSTJZbHdjanVV?=
 =?utf-8?B?Y0ZKZy84cU1wTi9nVTd5R1FIbGNmdDVwODluT1FCQWNyTTBJaENOUXZ3b2Va?=
 =?utf-8?B?Y1V1dUxNUTdZUzA0ZzA5M09BL0ZhV2lXWGM1RzNpS0JObUxjV09wNmpRYk5p?=
 =?utf-8?B?N0E4ekhCNGpSSVFWQlFqL3QwUmdJc1VpQUZGaFB0emR1VWRiVEZERDJTRFZm?=
 =?utf-8?Q?mVuc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d270be58-4769-4d37-6e71-08db741ff2a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:27:56.8218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5MA7e2ys13Vkkz2P92IoLk1FEZzjZi6nV31dEOjsoy30V4JT6tA3Y4NYnyM0x+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
Cc: Sean Wang <sean.ns.wang@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 14:25, Mario Limonciello wrote:
> The `DMUB_FW_VERSION` macro has a mistake in that the revision field
> is off by one byte. The last byte is typically used for other purposes
> and not a revision.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 7c9a2b34bd05..2a66a305679a 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -492,7 +492,7 @@ struct dmub_notification {
>    * of a firmware to know if feature or functionality is supported or present.
>    */
>   #define DMUB_FW_VERSION(major, minor, revision) \
> -	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
> +	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
>   
>   /**
>    * dmub_srv_create() - creates the DMUB service.
