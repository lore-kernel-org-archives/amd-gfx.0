Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E190BC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 14:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199E610E8B5;
	Fri,  1 Dec 2023 14:38:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B80910E8BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 14:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoTRkTHDFDBTuG1L9cnm73r/i7j9vILSjdu/S1meGfYKoSsck4bVTq/JOXURQ50gAc1IpPrArtJrh2fgxiXPYp9+DnvmUyKtwKx5DJCe4WCzjFEIwaQnkjSrdQiL1LeLOWEJ49MY6FRMDx6dS5qlTuPgh/L6fcfEhJ3VZJXr0s6WL/siO7t+jpCG3+4keYj529Py+3gJ1KOo9yoeDKjFxNS3imeP6xw48ALxrO5a3znN+/sFKlIbzqLYBEDWnYMgM2XPlQ+rVPnth+ZIFzUKMtNF9+ZfPV732xVL+tpfk0840I2cBYp7zIhTKd+ARzFMi2s0MT2vpxsg7+PSabb8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mg8ry+K/Y2iHsoJjR2MT9Pi/C+15Q90Dt5HSaYOvWA=;
 b=gBH6QBu58tkfGHogQpdNYPY+65NRrdQSwxo4Z0ocUHdcUaNKHb2UrLwr9t+y2tlu8Aso9bNYH37wvVopUS0dCtwMcKofs/Tz1sb6L2ApLMWUo/8NAxdwB0VacsYGCKbKWjdKOwUGZX55Vg9bLkgBEU40skExrZMQoldYD2eITwAfT1ePh1df8zgTq7xN0YdJ8/CbpnRZqXdfVGBS1pNBvKcHc7DGpBStVd2eBcj2Q1D4IbbXATfPwqc/sSbwMg3D2X9YKWJHqSV4/65JIhkbYIfa1fgYKvfc5eM1vm18NqVg+fA3aYjZueyMfXrDtnJxfPyPHwmIYpy9GBBjS8cVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mg8ry+K/Y2iHsoJjR2MT9Pi/C+15Q90Dt5HSaYOvWA=;
 b=BrdNxZUX5xRTEK0xqQKp3yH593ifJ6M26zjyFVl+xzr/iSEyAry49aIPPVV8CUcJABajvNUl3ef+2UtkpNxScYrAoEeDrnYjqsB4+neK4HS5SwufqsKuFJuXHYUU8jaMpe1Ke4H2BD7rnyGJgV4Inzp2eGU2vgoosFnsVoCxX+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Fri, 1 Dec
 2023 14:38:43 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%6]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 14:38:43 +0000
Message-ID: <0bc0e25a-09c8-46c9-8846-68fd1d103f2e@amd.com>
Date: Fri, 1 Dec 2023 09:38:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Increase frame warning limit with KASAN
 or KCSAN in dml
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231130224344.495215-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231130224344.495215-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: d0035c10-453c-4ac9-37d0-08dbf27b379f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vNsKjZG9Rp5YC78+OXaZxHil6lx8mLAxkQaQkquLSeCnNcW2Uo1nlAC1aoks/RBZhKq9nRzM4tPEq9iT8U/uWBQcvVj5NT1no6HhjOgagnDeAXK5Bn4Yu/Dr61Hn4fkD3EfCZ/nFA9iWXDmFXgoktUpeg/vGjTUg4O2EL6Au0oPOt7+aqPV7JXRJcsvIr+fuB3+fVaIfdG8kepHHp6uhMhySx5ux7Ld7F+f5Kwno2YkEZ7L4KWwcypHuQQALP8sKSkA85njWZtjjXoHj0vBGfObxsF19Ai/mhbuDkYISzmu4PXVJhW3VG49sMHDVXZksaQuJ6fnfMZX4OAh6NIO5kuIegN6I/+nGHPGE3FF01Htv3lY1MvArp5yWPzHep4EZmu+CyNnOOT2FMBE7q2rUxCsL4e1wsGUtcZKp8G0V/V32JfmWV8O+tzfpGiEdJ7OtZmPYIAP+TgFszZCh/8U6hXBGtm30TddiRFnvw5NzUjyfFiVJqTtah8C8xb2u8cMf80CwhBBLC3PVL+qgn+ln09r+YMBLT6ncwYIp+9DjPCBNu1IehgCqJ0CqhPMMrP1byPHNA2oeI9EFExUONbhBOWqpWG+ZFaIfsF/prtxoVx55deta0ZlbMIV/X2Ay3kqu2ZchmcWzOio1nC1N86lqo15jEuhONaWyH8PFRSKc0DHHapxL6ct1mZEVYGLEnrO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(41300700001)(2906002)(5660300002)(44832011)(31696002)(86362001)(4001150100001)(2616005)(53546011)(6506007)(6512007)(83380400001)(26005)(6666004)(966005)(6486002)(478600001)(38100700002)(31686004)(4326008)(316002)(54906003)(66556008)(8936002)(66476007)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2syaXdkVnNpcFRra2RGdGhoUCtMSFpTLzRHVlY0NmVwWkExbHpnQnk1eDMy?=
 =?utf-8?B?Q3REak9xY1ZWVGl0TFJ2Nkd0TnNkak0vTWNsbTBWQ29TOERXQjFsY0xENUxx?=
 =?utf-8?B?bW9FaUVlMDNQRFo3RzlPcVN6Mm53UVRFY2Rrd3hDdk5oRDRlaU5pVmFJZyth?=
 =?utf-8?B?QjZ6S3dPM1UvNUpQM3RPTXlwUTcxZnZFWHhwWUNuSy9wejM5dXMvcnZ1QXlE?=
 =?utf-8?B?cGdiTVBvNXY0UG5QZlNQWkhkd3lvQ096cmphRVRINzdGQmpwVTdld09FVVJ5?=
 =?utf-8?B?b0x2c3E3L20vUlVPWmMwN3pXVkFML0pGU0kyeGFQOTZ4QzN3TzNWbzc2QkVH?=
 =?utf-8?B?ajNQRExNRmF6SS9STGhjWDlMOTJKZm1FNlBCQ2k5V1hrQzZuTjVZU0EzUnJU?=
 =?utf-8?B?aUlCcU4zQlp5NVJKanVicm5RbFVZeklrdTZpYXp4WjQ2OFpJSEZHOSttMm02?=
 =?utf-8?B?eXVrVFBGRFZaNytaMnd4TkRoa29nNHFhYmhRZUJkV2JCUDMwRnRsVFVUak10?=
 =?utf-8?B?RS93WDUxNkY2YnJIT1kwdHBNck5TeWxwcXAza1MyVGE2MFZ6LzJYWjVNTXhv?=
 =?utf-8?B?TGJjVXkwNkVkOEJFYitGMTdKN014TmhpbnA4aE9TVndXK2UybHUwMjJLdk5I?=
 =?utf-8?B?dzRkbENDK1VDczFpTUg5VGlHeGN3QmhyZHFKTVVTWXVvWDlvblgyZkEvWHBh?=
 =?utf-8?B?QlZWdHNUbGlkQzlPSlpnUFV2aEY5NmZOdzF0cHEvK3dNZFd5MTAwclBJd2Nt?=
 =?utf-8?B?K01VNUFtMy9yYzF1NSs4REZyU1pRSFM3ZHNkNWdhdFBnL1haT1JmQUxQQVdw?=
 =?utf-8?B?RDdtSllXUitVUmdCT05oQW5SR0g2Q3oyZTNQNFJsSWpENzFFcG05TXZyL3M0?=
 =?utf-8?B?V2ExOTdXVEJsVzdlSUp3Si9UOGhPK3Y3ZkVqNWlJZVhkb3gvSDZ6TVA4YTMy?=
 =?utf-8?B?cXk0dDIzdnd5QTFXREVDL1pPeGVRM0s5emo0MjIvaVJtc3lUK3FVRjV2blMr?=
 =?utf-8?B?UTNzU3IwZEVCUHBPNjRYVXRBT21KRVVmTTNGUnN2cVI4T1lYLzBvMGVtL2VI?=
 =?utf-8?B?SXlnS3QzYU16SnU4cU5haXpEQWFmZnNMTkNNZEZTbkFua3JIL1JxQjRyVWpF?=
 =?utf-8?B?d3RyZW1CN1lWOWNYTEthSk9QcFJNNjBTWXJtNzVWSzZaMFlPSG1Lb1M3T1Ja?=
 =?utf-8?B?WGN1TTVNdzVIU3hhL1VteURmd2taV21yemlUVFNxS0NQRHFTaXJGQVVwdnZN?=
 =?utf-8?B?T0d1THlEYzlxM045Z09aSWtLS2tRZlBUdEd2MElhZ2x4T0tmSHV3MmxUVFJL?=
 =?utf-8?B?ZEtmU3lxUC9LU1hZUkV2L3RnUTN4ZWVPUWJNaU0zV3lSRlFCYWo4Sks1aWJn?=
 =?utf-8?B?aTd1YUZmaUdlNGhZT2JZckw1b2ZDMTBJSFNhd1hvM0VhMmtiQ1dGYlhMWG03?=
 =?utf-8?B?S09DWGlxNlpMbHpIbFVIYXNpZ0NocUQ2eStadE1pUm1QdGtUcHA2MjFNTUkz?=
 =?utf-8?B?R01rSzliYWxkQjRmK1VQMkluNDZtYW9UeVZjUjZMUytkU3dTOEd4d1dPbVdv?=
 =?utf-8?B?TjJvYmNzV2hJTU1vWHZkeGpkNTBFOTI1T3F0NTBtQVlzdzVITjlxRHJjb1N3?=
 =?utf-8?B?RHdrVjZiRDIzVHFwRzNyZWhkYmg3N1d0VjdmSDlmdTRlbWhxbG82c01EeW5B?=
 =?utf-8?B?UDBiTFpMcTNxZjd1Z0I0TkdzYWJTSUFTVXNvaW5PN2FiWVhuR3JuWkNRS2hm?=
 =?utf-8?B?RTFLdEJ1MVN1RXhlOSsveTc5ZGdjdWVzM2R5OTJ6aGg3OEM5UlVnSkVIM0J3?=
 =?utf-8?B?bTlNTnhzZy91ODZ2NnZuRkR3SDZxOXRrbnV6b3p1OVBaeXBQRzF4QzVzdnlG?=
 =?utf-8?B?bVBhNEE3d2txSlZkRmpsMnFzNDlLbjFydjh6VGk5ZVhqT2ZtNy9UR2FEejFw?=
 =?utf-8?B?UGZTd2VJSVQrVTliNmVTbGF4eCtScTNxd1lhd3BYQXVIaEREZTZEb2dZMHBm?=
 =?utf-8?B?dlhDMXJLQ0pqdDZGemYyK09HZVphVmZITnBPdGF0VkI3ZEZOdXhNVlYrb0pT?=
 =?utf-8?B?dmtRNHE1cFUreWhkVkdRbGRra2FWQ1FaMFhMYzFKd0VGUXFDa1o4ejlRWlYx?=
 =?utf-8?Q?BNe07IC/25LRqYDrKG0b9CFRW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0035c10-453c-4ac9-37d0-08dbf27b379f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 14:38:43.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xatERFHUTo5Y77TecUq9QH5eJ6f1tHxileHBnmCK5HuMcekCMWw4Oms2fFESBg1TwwfFG89yluTRd5PO1UouXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, kernel test robot <lkp@intel.com>,
 Samson Tam <samson.tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-30 17:43, Alex Deucher wrote:
> Does the same thing as:
> commit 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml2")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311302107.hUDXVyWT-lkp@intel.com/
> Fixes: 67e38874b85b ("drm/amd/display: Increase num voltage states to 40")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Samson Tam <samson.tam@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index ea7d60f9a9b4..6042a5a6a44f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -61,8 +61,12 @@ endif
>  endif
>  
>  ifneq ($(CONFIG_FRAME_WARN),0)
> +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> +frame_warn_flag := -Wframe-larger-than=3072
> +else
>  frame_warn_flag := -Wframe-larger-than=2048
>  endif
> +endif
>  
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)

