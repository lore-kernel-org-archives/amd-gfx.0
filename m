Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E6EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 19:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE2110E249;
	Mon, 26 Jun 2023 19:13:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4977A10E248
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 19:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEtzM/sTuHziDis3EpXibrdHciVqzk1KW1AjSDweoHjXq1Q2e390C0B9noqkcsPLUwHAFOT6LtZr3EbCQw9bS6S6eOEnEpc5zPUpOCU51DhH9E7GabRng0u4XqoNoBhvJOaBm0u+0/InwEngFpQuiCiz/KUGuIreawuBlk6V35vfOhtNBsaresjnKUREzFvWnKU1oabIWhH+ofk/Z3FnJhO7zLDtQqHWJbEvsX7syEFU5HJV0LQeIWzs1QAg+yAIscFvAvufk04dSWJOr/FxAfvnhfGca1y5y2pcQssRb+HAi6cm+qFe7PtwMaUjXOHi68lj5WKdI096TZPxiIgK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nozGh3H1O1NtzdrU/cGlX0JzKEjO5s+rFnivuDoJvI=;
 b=PjEt5I00vb0GSSRx8j74DksIhhDmovQ83qR7lxqnBz8vYCAMfHuCiC2QNAdigmbG8fV2KuB0v2qyOjderhGCr3KtEtGhkD1QqcjnPshxH+5dcxpuTNlzO8nG6JTCVQWzzam/LPyOUo6p5sz4KCTyTQPoxNxOjPNO9d0os2E8KW9mtnHExdLiJRGwqmmSkasMNILKikuPkMOjkpmDtQB9lhHv2MWWannkf+K3FnVl7vppAsDXX+q463rokXSRPfX72ycJbSRgZwEF7iFwvXgjrnOgSe96cICTsaBnWhG8M2DDn93H8A6+hEnfCghLszbR/j0ODexx6OcQ/xorhlRPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nozGh3H1O1NtzdrU/cGlX0JzKEjO5s+rFnivuDoJvI=;
 b=EaJuf6/dRKk8NqZXlU/Cv+qiix38LcDmQBtqAmYVIi6VnR6LrfmiU/XSdQSx/T+Zbv9ujwlPklw3IFzX8n4hceLoCxtGfOqIlYrz3yLjzzZCvK2XWvFiIrFNbLeCiFiA0l9dhWDeH1I8kPWHqRBgrowebFwYnEmXp2BZBCao0Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Mon, 26 Jun 2023 19:13:12 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 19:13:12 +0000
Message-ID: <58a3ac87-59f9-8d26-0985-69eacfc0b4bf@amd.com>
Date: Mon, 26 Jun 2023 15:13:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] drm/amd/display: Set minimum requirement for using
 PSR-SU on Phoenix
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230623150522.32494-1-mario.limonciello@amd.com>
 <20230623150522.32494-4-mario.limonciello@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230623150522.32494-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::8) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 427545dc-1503-4a5b-6f0e-08db7679629c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxNqjSVS7rdSM2yTBk1H5U3LGhyyXTCpQHO8K2bhM1XNF8WEtc3Y17h0D37bIoOYzsFIwFS4Tz1CkR0zIyhoIGUWbQFylMF3KguZJDMY4F2HxOyxC5hFmIlcRr60lvGykvexIMMHdi7q3h5r6GaYtHHdvQsAH3LkXBQj/kbrjEcFtfeS7hj20TQ3s7+IaANqhaNtKcSB/JOQzRr+EaVlQCkVV69lZ7WtEvaUASfz79eeQhOVT3J7jLZ1vZDcJUbaz5R3BXZPIoXuaTH/4gJhHAn9vV5mT8Qy3jX37RA+kQbp888A/zGw1rTQtsmVCIKMZdEMUGdNxU6OhMd0jwrr/QVzZDyFDCgUGFs2f78x9cqJbiEFvsfWXflHr3XpheXQTDC65NQjwp2Ok+PDrk/irsItKmz1LsFlcT1sbLOSqBMoN4+DQmtbmgOjgecwt0o/s5SkLPmVME2MuObhY2NVctl2RXrVyYp10ocUQHsh3eDB5ipTSPIwpBkylvIMB15ET6DHYq/8h7Iy7E68kH4X2wD5bwAlLZOl+3U1nNerNP+uLQZ+c0BJnTwe6tGuhlvSeqx5X910UzMWotSBm4TkccbDdK0iiOdJatT+fYbpTm4WHg2aMefehnpqm/F2JrBbuCk/Lj7sVHiavJPpiJBNWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(6512007)(4326008)(6506007)(26005)(186003)(53546011)(6486002)(478600001)(54906003)(2616005)(41300700001)(6666004)(2906002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJCZTZHZ3FqY1RaaGdHSlVUTm56MWdHUXp4ekpOZnFaTDlZVFlDcS9uMjMz?=
 =?utf-8?B?d2x3SDNBV1hkcnVoK040Y2hmNEZoZndCS25FMkJhYXM4V0s2MFNYeDVQZ2pG?=
 =?utf-8?B?Z2VWU1EvZ3pmSWNQR3BScFE3UGQxT01OVGdjVW1FOUpVdWdqWUo4REt0YWVD?=
 =?utf-8?B?c2puM0NWTEx2aW1Mam1xcVg0RGJ0ZnB6VEc1TStvTW12NG4zQ25TM2dCbFBj?=
 =?utf-8?B?cFF1VlMrSnhnS2NPWlRPZ0JXUnMrVzgxcFFxUHZ1ZUo5dEtqMmtVb3JOQmpU?=
 =?utf-8?B?R1JsbFZnOHBKbkI0UEdxdldSSXRvN1F3RjNhSkVVVEl1WGl0Mk53K2dsRXBQ?=
 =?utf-8?B?VVFJYTUwUWxtMmd3dUNEcHBYZENMVWVvVXo3WCtWS3dDcUg3TDZnTVFmdVVC?=
 =?utf-8?B?OXdOSGFQdHRrSjAwY2ZKcWF2M3hSUHhoZm1VV28vdWFDT21XNUQrMXUvU2Ev?=
 =?utf-8?B?MTF4Rm56dVNPbjh0OEhHL1JQbS9tTVdBaTZjMkZLbHREQ2FWVUtUd3J3cDdB?=
 =?utf-8?B?dzVvZitWMkxRY1Q0NXFWbmZXbG1yTFB6YVp5aE81TW15c3RSRXpZQ1IxUWhV?=
 =?utf-8?B?b3dUMXQ0eS9OY25WZVJoM1YwVXIvMEJ3REZXbU9abzNqV2w2czNGZHY1L1lO?=
 =?utf-8?B?TE11NDJSV0tnbFIyMlk3a0pZZHV1dURSZkNBcHhDeWk5WjMrZ3dZakd5ZlJW?=
 =?utf-8?B?VEZISjZVTWRGdXgxNENlWUlqVnJxRWdvWnE5Y1JRTDVoOHF3SlgvWmZWOVVW?=
 =?utf-8?B?OUxlYkFzOWxmUFFLTW1sL2VObTMwWkdxMWlxMFNNOFRhcStraWljTTJNNmpT?=
 =?utf-8?B?MXlxSTU5SmNtM3BGNmVEOGo4d3dlOXcwTThieWRnbVNOTGVHMFBXNWFNVkx6?=
 =?utf-8?B?V09CczgvOW01cWFuVjdyRWIvWkx4WXJNN1VDUTBoRFZ3M0NLVDF5LzhoYTdH?=
 =?utf-8?B?ZmZDN1BYblh5RGFXTE9DUGdGeTFGVFRiVWFyZ2kwUWFQTFEzRDNIUEJML280?=
 =?utf-8?B?N1VhVC9tY0ZHZ29UTmZibmp1enNiREJTUmNKTUVwLzBsVzBUejhiTXVhUE9n?=
 =?utf-8?B?aWNiOStBaFNDWE51TS9SL1AxTHFMN0hzcW4vSUN3VHZPaFVreXQ4bjc5czIr?=
 =?utf-8?B?N2lFZzJGbXBIbFY5Z1NIeENrU1FVT3A3YW10MTZaV0RrbnR1ajVhV2M0Uzla?=
 =?utf-8?B?dVVVbnpMWUZtUGgyYUs5allyYnRUU0ZQeHByL0VCSFlGa2hmOTJJU0o4RWRD?=
 =?utf-8?B?SC8zL2p5SmZnelIvQnBNNmVFN0pINWZTNU9jb0pZbldXMVA5eTZDR2pPZXlR?=
 =?utf-8?B?UFc5NjhKb1FCMjNDWmZQSi9iRXNscGtOcFV4OGJubzU5QnVkd3YzU2xqM29j?=
 =?utf-8?B?bHU1MlVaU0hsMS9nb3g2aW1BM2twVzFYbHF4WktzM1hlT2wxcXpuUDV6angz?=
 =?utf-8?B?S3VoVXlEemtQTDJicU5VcmpoQXBleUpWblVucU1QR3Q2OUw4ekNicm8zS1U3?=
 =?utf-8?B?UWpTRmdqT1dLT0NzUHcyS25qajF0M2U2cjR4a1FGSEpXTWcvVnNrQjU1dHBv?=
 =?utf-8?B?aU11THVWa0N5RHhZS2RUbmhpOVdBdk1nUVd2SmR6ZEdWWURhSGZ2d08yOHZK?=
 =?utf-8?B?cG13K0QwMDBsTkp4bnFUWElqdjJjQ1BhNWtKaWp0dklnVWYyU1ZmenJsNlc1?=
 =?utf-8?B?OHJ2WUd2dmpMeVVPMVBiamUyQU5tV3Vidno2cStYNzVaWjQyMTNhbzhITldt?=
 =?utf-8?B?WjQ1U1BOekFuaDBJc0N4dkE1cEFuRDFRTDBJSk01b1NmNWFvSHpWUlBVTmdh?=
 =?utf-8?B?anUvMFdDdmxrUmJHL0FpOXFqQXBJMmtvZ2VFNTNxNCs0ZlJEUkJyZ1krMW8x?=
 =?utf-8?B?RTFFdlIwLzc2SUdCNmdHdjJWdXh3NDVUeHBqOGdsWS9yMmRCT21GczlJMGR5?=
 =?utf-8?B?RzE3NzljOXh2TCtoem9keklRZ3FPamNmRTFXSjZTTFl1MnNER3NrTFVpU2V6?=
 =?utf-8?B?Ty9vdnRJaGVJdElDWHpQdldEU1lEVVFuU3lMbDlpdzMyNVVuUndPZXljU24y?=
 =?utf-8?B?Y3hCZThxS0lTN3dsOSs2YWJ0NnNmay9NZkRpR20wNE5XcWNTQW5ha1hrMDRJ?=
 =?utf-8?Q?AeoM/acIjdx7EiItYru8FGglY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427545dc-1503-4a5b-6f0e-08db7679629c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 19:13:12.1990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlCEqX6Z2Z0rxWCXA3eYjitiyYlqmyoWGRo2xrCVKkZkPv5X4Sn6DzRk2KL+VPf0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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



On 6/23/23 11:05, Mario Limonciello wrote:
> The same parade TCON issue can potentially happen on Phoenix, and the same
> PSR resilience changes have been ported into the DMUB firmware.
> 
> Don't allow running PSR-SU unless on the newer firmware.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
> v1->v2:
>      * Fix a s/dcn31/dcn314/ mixup
> ---
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c | 5 +++++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h | 2 ++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
> index 48a06dbd9be7..f161aeb7e7c4 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
> @@ -60,3 +60,8 @@ const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
>   	{ DMUB_DCN31_FIELDS() },
>   #undef DMUB_SF
>   };
> +
> +bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub)
> +{
> +	return dmub->fw_version >= DMUB_FW_VERSION(8, 0, 16);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
> index 674267a2940e..f213bd82c911 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
> @@ -30,4 +30,6 @@
>   
>   extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
>   
> +bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
> +
>   #endif /* _DMUB_DCN314_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 7a31e3e27bab..bdaf43892f47 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -228,6 +228,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>   	case DMUB_ASIC_DCN316:
>   		if (asic == DMUB_ASIC_DCN314) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
> +			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
>   		} else if (asic == DMUB_ASIC_DCN315) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
>   		} else if (asic == DMUB_ASIC_DCN316) {
