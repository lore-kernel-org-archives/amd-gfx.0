Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9B6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 13:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2C10E4DA;
	Wed, 18 May 2022 13:56:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D056210E4DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 13:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/96R8Rendk4kjMLmfny2X9mSA1cjPQiQKdp3YZYQHnUUKvrF8Flb/IzmdUmzvAvT7Tqxc+DU6QkjofkoxAtOllNd5bymsghQrAbLi/49GMJ+B924FWL1fpOVsT6HG+EMdIEBDNv6uEExLbgQbr5CRJiZCDf8dp6z74QszNISqy137kBna1kH2/X873DCLRbZfRCzv5lmPUZf5TYvURk8n29SWn1nX0NVAGym0kIvmF86dr6dii+AFI/tVO8jNMs9onNhv8xKnaGBBczXl2HgD9kOq67DYIiUIEUjLTxaAlswGo22ymCaelTPfNTPnhrYu2ZSoYKlTerwWLryoisXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+n4B47Ki64Vt3UXNA4ex1jLQ40GnXQYdK6PanOcllo=;
 b=J+HBDd4+vmNZhyRl3CWf4kJUzQySCGwSBAbjz+XqgadnCcJLkMCuRYOyx0NKsVpqM6r1Epfi/jI4DNqbcy89ar6a5XNn+aljtEgDNtmN27B2euqbuMbRk+VNkCjP1Wrc4aiFo/5Y+ZuTTwlmKXo0Rdg9nKruf1SP2rOPYhi3NKKtOFFCSkpaqkFaEcNc7P/m/H3cwNiwym2dzOSXxOMSoE9LILZT+5H/MShzEWr/Ls0edfHF7G+A3qhMEDc8llLe+/eFBHWJvHM1SYJuwu029xzjckaXZ4KWOJIIrODI+0mNaNKsJ8d05G2utgoP+QkWP0zZqQYQUDyQeceFee+SMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+n4B47Ki64Vt3UXNA4ex1jLQ40GnXQYdK6PanOcllo=;
 b=n29Be0G4q7FAKS8RO+yaPXJ2Ry8SnBA3hBUsM2069ig+7vGyIiTXYw+wZfGBE9UrGNK8DWb2jkQJM3SZ2bia8snUX7pZzl2e2VM5bTnbKIyXukLZzu0JHp/gbbcgYT+CSx6WIVQrVN9Kh5h71iADAKLTe8vazCS+YHedUOS4Zow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 13:56:46 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 13:56:46 +0000
Message-ID: <da3ce8ab-8d24-44a4-bd69-8b295edd1def@amd.com>
Date: Wed, 18 May 2022 09:56:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] dc: Add HDMI_ACP_SEND register
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220518074942.1519871-1-HaoPing.Liu@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220518074942.1519871-1-HaoPing.Liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4edcec1b-5a9f-4234-75e7-08da38d63f28
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6315:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB63150C4D6A6C940780F174AA8CD19@SJ1PR12MB6315.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1luopfOWmlF/2yL9lEJL+qyPA98Fkr/5GNSTQmDoCXEg8nsJbaV9cYKkKwp+pTp55htqNIUm6LdkyWfQDpZmSjknjg2vxlxTuU5dB0UA+X+qdavE+zkpl526zdEwPLFLEtL2rQJ+7wQq0GA1PNt0tX2EuNYP/sm75wKIQgY7VTR3HvMBlXP/R8dTO7r22vEI+13EOKu3MeVImpL7LUNvYd3yzqhLz5mujMmCqp5ZkPREYqx6MDvdYqoymy/Ln0Ucf6U5TLculm3S+ttiLTUPzAKHE2o5c8piP+MC6KXrM+5gGJKSf0Xi0VlQArgCEgSKYWkJtlCvv5Izx8Bx7GP1AEfz2GLnxaZcbDCex3+oz3Rku1yBQ8IGeyHceNbBE0j3sagT/VKV+7LopPseKajRx9YJw79H0GwaSCeKdgNU3Oh4eg0cMu4Hu2Dc0Lp0ZhBlWVr+r5/h6SkQN6pfL0S8vTodKhZZiGdbvZioq/zRDRgpkctndvXB+POF+QEsabXd9yLzG73HXgvKD/JOVpoGo7BcMTxytn/7LA9NbbPvlmBhz6gmltOgg8RdTA3YGo9rWldctQehDeWK7nR3Rw5ES01pV6c3/BeTNJzS1syVLAFllNrrnL00p0aG/l6r+95ukYv6DMwCkfMNrm8EqAWmCZwsukjfhnTG3TUpynMiCjdMhUNou1tEaehgPCLVb4gotI7psC6dQA72kLiDM8I40Gy4dk7JMQ0sv0Nt4ofPLMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(36756003)(5660300002)(6506007)(6512007)(2906002)(30864003)(66946007)(186003)(83380400001)(53546011)(31686004)(2616005)(66476007)(6486002)(4326008)(8936002)(508600001)(38100700002)(26005)(8676002)(66556008)(31696002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJZbGlacFNhK0sxVlN2YWxWNDJkWWdETGNTdkdhQzFKN2dIaVhQRlZNMnZ1?=
 =?utf-8?B?WE1kNFlWaFd5T1JVUHZFcCtWNlNFSTQyRkdKQnIzOVhaT2ZPaTdObC9pbTFh?=
 =?utf-8?B?MXVVYVJjYzVaamJsZkxRNG4vRGwxdWFZakJTbDAwVTRnZE5NVUpGUzh2dlgy?=
 =?utf-8?B?MXlpSWUyNlpxejVYNDRCUTVxc1VtUTlpVlRQZW1xcnNrdm1yT3BOUVpNSDdY?=
 =?utf-8?B?OTI3WHlBTkR4RjRnMjJOYUthVzVSNm4yU0ZadG03SWt6c1kxeUFXa2JCR1c4?=
 =?utf-8?B?UW9PTDhDclFpQ0dUb3BZT0VEVHlTeCt0MTd2WW5zR1VERzFqUmRoT3pweUZX?=
 =?utf-8?B?bTkrWFJPR1BlS3dRYmpIZmdJYUlNZkVMQi9NWDdEVWswcDd1WHFXVkY0b2JQ?=
 =?utf-8?B?c1FFelhZTWlxZWtwVEYyK3EzRlErb2lsOTR4MlFRUEhzM1VRd3NKRE5ETGhE?=
 =?utf-8?B?dVVwdERPbXBQU1VERWd5TFdiTE5qNmhocmJ3N0RkRkR5a3QzYm9VMUxQdHAx?=
 =?utf-8?B?NVZLOW9Wc25VZmZrTG5GZHQ0VGdOVCtUU21MSnptQnZjUCs1M3NWMVcvRElh?=
 =?utf-8?B?OXR3WnFkTXhhbHRZSm0vMHp1REdEaFBkbWNTSm1XT3JiWlpxbnBNOXh1ZnVS?=
 =?utf-8?B?SmNpK25jMFBnMDB6K0dlTmI2K2l3bU56Q0hIU1lMaWc0SkJTaklXRDI1VTky?=
 =?utf-8?B?V2V5MXpOaDByWCtlTnlLMmFwWUZrUGVVVHhuZFFlU3ZNcy9QakYzdzkweDN6?=
 =?utf-8?B?QXYxanZWNEhFQ0hNRlpCa3JoT2xPMlM5RDhxWHFsN0hKUVJyblhVd1hQOExN?=
 =?utf-8?B?a3FLRjlxZ0ptTHQ3Uk1wc3ovd1pSTmNtaTRLTE9wUVB5b3dLN0lZSTRvVHZv?=
 =?utf-8?B?V1p3YmdhR0M0YnVGcGFrOTU5Z1N2dWV6S3BLS2xDMFZCdlA2YnlIcnVnajdK?=
 =?utf-8?B?TEdQU0pkTzFuK3ZSQzR2WmdvTUlnMGUrTklCcW9mNWN5R2s1WjRXcWFxRExJ?=
 =?utf-8?B?TU53aFVSTjBrMDFtdFRPMHpJWElmdjJ5VVUrZU9lTE9xMzlDbXBuZ21xajVp?=
 =?utf-8?B?Um9pZVQ2a2FPcElWSzREOXZwMHZway92Znc0Z08zREtUbmpNbjkwMmtLYVZn?=
 =?utf-8?B?WmhjL0JrSWlWcE9CbXd2clhQR1drUVRWQkROVDlJYkhTd2pXdjAzanJ6QXV4?=
 =?utf-8?B?VkRVZVZ2bVlZcXZMWGc3NjhFZlFCSXJNWWloT0tpZjZmZmVzOUc2RVlMUHhR?=
 =?utf-8?B?K2ZqbGszaUtpQXBDTis4ZXNvYURseHdwVDJuNkFRMFZmaEordXIzeHpkQmFS?=
 =?utf-8?B?QnBBcGpEVVR4N2R4WTJNL05EaTRJUWxtazN6d3BLNlJia0F5QXp6US9NczQv?=
 =?utf-8?B?ZmxzTUxoR2NvRW9TYllnL3JQNHA1N0IzQTk5VThFWEhxTnB3RGZ0MXJxWDBP?=
 =?utf-8?B?RjEvbjBNcHJQVjlERm9DQklOMEZZR2kwdjVaYnVRaFlBL2lCVmJ0U21LdEhJ?=
 =?utf-8?B?YUdHOEpRczArUlY3ZWtUSEJCVUZpNTdtUlVsWjF2VHg5bzQ4aEdoMHpyMndC?=
 =?utf-8?B?dXFiNVhJaGdmZE5NL1JQQWJ0Q0pZb3B3Nm91Y2tSZ2Q2NGR6V1BjMXpabmYz?=
 =?utf-8?B?SXNIQm0wVFIxT1BIVW9HVCtOV05OU0FkZ0tkS3NJMVpnQWRlT1pua01jL2ZP?=
 =?utf-8?B?SERtSWRmNXdKQkVzMXluaE53bHhackVPV25VU0ZNd3pwdzJ6aGVmbWFyYno5?=
 =?utf-8?B?b2NxbDNuTWlaWEZtY2k5eUEvZDB0Z0JkamdIZWRsYnZPbWp2SmZLQzFRTkcw?=
 =?utf-8?B?d2RlUk5vMmNrNE4wcWhsU0JOVmlaYkZKdWwrVU52QjhsVCsrQ0NqRTNwT3VN?=
 =?utf-8?B?UlF5dlpDb3RNVGM5NXFJL1J6Ukp2SXNUQzdFZ0FGaEZ0OGN5YTdUUW5aSXJ3?=
 =?utf-8?B?NjExVTlSalNvQjhERllYMVA4bU9CMTRNYnl4enJCMDRKOElCU2Y0YzJXaXJZ?=
 =?utf-8?B?S2xEU2FtL3U2QXBLaHRqWmVVc1l5OWU1dGozL2JsRllqMlptQlFQYVJVN3pM?=
 =?utf-8?B?L2cxNCswNEZvNEp5eDRSL1VsSXBPV3pBTzExUHhZSE5LYTREU1ZjcGNVRlhI?=
 =?utf-8?B?WUkwR1hWUWFvVmZOdjYvS2VVY3oxcXhTRDlyK25Rc3FtckdneTRmN2dBejVQ?=
 =?utf-8?B?N3VxYWhUUTZZd1Q2d2g1Wk43Q2hoUEViRGE5bnVJYXhSYmYwQ0JoRHJ6a01P?=
 =?utf-8?B?eXU0c0lMNDVDekxUSWI0bDBDUW0xaTFUUENmeVl3NTBiTkZTbVhGSWgxMnpv?=
 =?utf-8?B?ckU0Z0tBdEJKRWd6UVI1QlBmWFhTVmJoS1paTXlKUDRnSlRWdEVUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edcec1b-5a9f-4234-75e7-08da38d63f28
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:56:46.2150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CaU1X4ONg3QedauPs0NFA4DdUTjDuyGedIIrCkMvi8Q6smZh7PJjYeri3/feBjRXHbMlsN4F/7NDm+KI6DZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/18/22 03:49, Alan Liu wrote:
> Define HDMI_ACP_SEND register shift/mask.
> 
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h  | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h  | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h  | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h  | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h   | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h   | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h | 4 ++--
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h | 2 ++
>  9 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
> index c755f43aaaf8..7a2c6b12c249 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
> @@ -6070,6 +6070,8 @@
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
>  #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> index 14a3bacfcfd1..fa1f4374fafe 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
> @@ -6058,6 +6058,8 @@
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
>  #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
> index 106094ed0661..39f6fde6db1d 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
> @@ -7142,6 +7142,8 @@
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
>  #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
> index bcd190a3fcdd..c5f4afac3b39 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
> @@ -37285,12 +37285,14 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
>  //DIG0_HDMI_INFOFRAME_CONTROL0
>  #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND__SHIFT                                               0x0
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
> index 9b6825b74cc1..23580907663b 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
> @@ -5584,6 +5584,8 @@
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
> +#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
>  #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
>  #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> index e7c0cad41081..a788ff3b68c0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> @@ -30357,12 +30357,14 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
>  //DIG0_HDMI_INFOFRAME_CONTROL0
>  #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
> index dc8ce7aaa0cf..c70f7ba94d8f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
> @@ -39439,12 +39439,14 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
>  //DIG0_HDMI_INFOFRAME_CONTROL0
>  #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> index 91969554e36a..ca1e1eb39256 100755
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> @@ -16956,7 +16956,7 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
> -
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
>  
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
> @@ -16964,7 +16964,7 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
> -
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
>  
>  //DIG0_HDMI_INFOFRAME_CONTROL0
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
> index 2f780aefc722..6104ae304099 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
> @@ -35487,12 +35487,14 @@
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
> +#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
>  #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
>  //DIG0_HDMI_INFOFRAME_CONTROL0
>  #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
