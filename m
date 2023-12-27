Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDE0C46CD4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 10:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E6E10E23F;
	Wed, 27 Dec 2023 10:22:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F8210E23D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 10:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZxvyCeQTm3aZlGi1UwyvZOo0/edH7Pjcpa+HcZS95otAkiwDtwMI0lOoRbWjF3SjZe1cSvCpM4rr/dhH76coOuYRvnxlipUgARWkvlPZqgbtdoeYta0UwnwZJES7TR7Fh0em3abO7L81ROhpk0p7sK48MdZFyjyFrh+0Rgcx9YxTqWgVbhFRhPji2hC9rn3awHzBq+J3JSgvk8v+YPZrPS86PgfgAJecduf5Koh2IzsA3BlKCUwQu6Wqu2uMRgR44Q22kpL+kLiqaNDQ9lmsWmxMbw9qmDOfRmPHfDQe3cD1KLn9sCt/SIeBJNhTxAmBgjcxe7dKNx3x55TscMrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o280mZSSxUe1f2GwOP0q6HmAhtEljy3P5X+na71f90=;
 b=MQ6F/Iy8aU+HCHgVHcHw+Lbn9YGgxF2CCZYEb2RR1Rvnx9aW6eBuRxsZhTn040Zy9yk/nKh06nPb0tgsz7i5eIdBjdjxuFKdSwv2BJS7XvNLt+b6aC0X8NX4nyUMeaJ4d3R5oEPrC3qUWgCzpcIk5Eaq0uMlZ1tPjvPU7G89+u4/EahyTGCa+jqM7GxVyaGE+sRea0heXOYSFv8+ag8DtprEwS6pRrvWJsUIFM4Em10uE7UHeC3eSupDQaK2zQopOGAT6B31cJYjBDcwYkNUMPoOqsf7r56Og0d+2gBRebAcAXxKQP3TbQ2tOUQwkWDDxKN6h3dbe1WCO6W81BuzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o280mZSSxUe1f2GwOP0q6HmAhtEljy3P5X+na71f90=;
 b=osjRWbiEq2G9RE4YTKa+OX0bbdZVK3o0v6l1R47f/zRUNvIJq9TN7AwOqHl7JDPbaQus09we9j8NLtGgVG1J8oG59heIFY8oi8GEY8uAcLb4ouSv4efJjfIHMm3x5zSSgfG0USPpqOLrqF1TBhD/utx4h1XwD5/EEsj+AzdBx0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.28; Wed, 27 Dec
 2023 10:22:06 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 10:22:06 +0000
Content-Type: multipart/alternative;
 boundary="------------lxPAFsUk683YwtV710WulH21"
Message-ID: <555f83c7-0480-450b-a001-4311fbb4d3b3@amd.com>
Date: Wed, 27 Dec 2023 15:51:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Remove unreachable code in amdgpu/atom.c
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20231227100417.3504719-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20231227100417.3504719-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: d4be1fe9-030f-446a-805a-08dc06c5aca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie4rJry91cpBM8O3JvPAItdVFzcTmV1WRCAoFyGbdDsK9ReHfBE/mlkyLF/TZZ8DqzUMHPgJ/kFA7XOcpBmQuObTfCVP2f0+Yawva6WGcP407MdlhkWcFRFH3IBW1Z87B55nHJyQ0NiwapAYoOIAaJGA2Tiy9aiQz+713tv11/4LU30nxu4WqxyywTLwfo0YlOwUL2RebaXFHp57o4btHUbez4hFFRVJMvGgafnZgcb2IYrKL9GqF3lMMaqeiMHHPrRzBRZg8tjs/kdemYg2NSg1uIWyDFN5Ic43UX/8hOKQ7yY0jsvFXDNleMdIQUHj5wG+aOlSsyXfOXTc4m9r0C2upvCo4bYEajKRqzlQJg13/dsQKjAG2F/FBPLczGG/CJ4tmw34i16gFRVSvCfDs+USNoUs56c9O8DvPm4mCmDE44pdNcpNQwpDTYXOWGLZq+r53H3dwbOEph1RS2YMyFb62SJ6hGW+zZyBqVhg9brsdv13varnwbJGlg4blQO0WgXFOa55OWSUKoerQMgC7qYppe4o9yLvzaCcVa/j4vxagKQzGx6fHOl++F4FwJUSTPX91vZZL3opvtHEmupVNql4Zs8elp1uXBCtem16erOSsVAxsppOkX2OArAe6tKn1L3RcfT0WJFwdMr45Ztk8lMHPgJcl1TO9neOv5Osrof7b3MTLjQnUc/d4Dhtfu3X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(33964004)(6666004)(6512007)(6636002)(6506007)(53546011)(66946007)(66556008)(66476007)(6486002)(31696002)(86362001)(66574015)(38100700002)(26005)(83380400001)(2616005)(41300700001)(2906002)(5660300002)(8936002)(8676002)(478600001)(110136005)(4326008)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5PUVNKYTFBTE9ZdXdBZ2RLclgwdEkrMHVuMHZKdnZYMzMxUUxrd1dydlBP?=
 =?utf-8?B?YUR1b2JNQVpSbEkrMkNYS1ZXTXJXUkUvT1pObkpMTmhTcFRKQ3RiUVYyWjA1?=
 =?utf-8?B?L3J5Vm5NOXA5U0tCR0FaZGhNdXVPUWNOUTRhaWMycU1URnF2bDk0Q0JYaEtp?=
 =?utf-8?B?VmhNdlluT3hBOG1HK3dha252ZXQ4VUIveDdKOFc4VlpldmF3Z1ZRQUhTZXdU?=
 =?utf-8?B?Q3Zvb3lLbmtMZThNWXlybkVzd2VtdnBVcStBUlMzME1odlFDYXo2UFZRcWg1?=
 =?utf-8?B?b3A2d0s3YTJHbE5uNTY0c3VtOHlKclFiVmYrT0NzaVVHbUlMcUpHcEtPYWlw?=
 =?utf-8?B?S0NVOGxUSFQvdHhCT2dsWDMyTWhTaE0zRWw0Q3BTcERBZkRyd0tJajBnbSto?=
 =?utf-8?B?S3RhSGl6ajh3U3hZeTl6Tm42VUFLUWxYS294TjgxWnd1dlZTQmtWeHJ1azJy?=
 =?utf-8?B?SllRejFMMkhoa1ZRQ1BlaTUxM3NoZ3VlUFlzZVF4aGVXVzZDaTBMTFJxVGg5?=
 =?utf-8?B?NFFWUzM0Nk56L3RnV0tPTm16SXNRSFcyVExabkxxOUZ0SU9NZTFsMjRnWXpL?=
 =?utf-8?B?TVFJRlA2UkhRT3NjY3JKbUJxcDBodWhZL0JiRXBDclBSbk1PaEZrN3QvMUxn?=
 =?utf-8?B?bEV5MUJHTXltamVBaTBLSEZBWGVnWjJHZWpvdVBFbTRjU1pFR0VuK1dHYkdO?=
 =?utf-8?B?dk9sQUg1UlVyRkRaM0JSS3hTNlYxWU9aRHUxTkZaWUhHckxDS2tlRkxyOVNk?=
 =?utf-8?B?aU1ySCszU0xJOEdRY0EyR0lhZnRDNnBXY1FKK0FVT09ZYlRGcWlUbGVmWEZ4?=
 =?utf-8?B?Y2FxQ1F4OGVlZjdLNDRMZmhRTS9iajB2YnU5OSswQk1EQUtqUVhpYVpWc3pZ?=
 =?utf-8?B?d1NnVmU0VjBmOGRvQ29NUVltaUNMUm1hRDUzNFhpUjF1ZFRvOUI5aExFZmZ2?=
 =?utf-8?B?eXdwVndob0VTcmgzbkRhYWZVa3FsM2N4cHB3YnZ2OXl2UEptUW9MdUF0YmJ3?=
 =?utf-8?B?WUZpWlB6Y0FLTk1seUZLdzJ2YlUxM2Y0MVNRbkZaK1ZzMC9BSVpQY21IRFpH?=
 =?utf-8?B?eVNRamhTME5LVWhWeC9sSG5JRkwwNG1NcG1PT2k2YWg3M2tYaXkyUHJjQnBV?=
 =?utf-8?B?M0lpcWRoRUNyVU1RdXk1U005U3RWcUJ3U3pRbHhXVU5TWHlNak1pQUh6K0Ew?=
 =?utf-8?B?RXA4dlhJSGlJcVgzdkhZYmNSQXczWVZRTEFnRXBDVFlsTFRmNFNhSUJpOUxt?=
 =?utf-8?B?ZnNiL2lqazRCWHdxZmpsTTZLRW9ZSEdIU2NOeDhhcTVQeitlRjc5UDN0cEFK?=
 =?utf-8?B?eEFGdUdqTHJVeGpBUXFTMllpM0xNUWFDelorUVdaalNURVFaZEgrc2FoK1lR?=
 =?utf-8?B?OFpNNUo0NTM4QzhIS1NlRHpmL1V1KzFuYnFqQkNQWkJwQlpTRFphYXFyeklI?=
 =?utf-8?B?cjBVU2ZrWXMwUFo5M3drRDFEcSs0Szloa2Ztd2JjRHZwWnJkOTFOWVJaazh3?=
 =?utf-8?B?aVJDTFl2TGNqbWdoV1NYSzdHaXVzZGY5eVdVTU95ZTlBR0xzR0ozR1ZTMjV3?=
 =?utf-8?B?S2Qya2NqZ3VybzNyRTBVMHBnQTJ0UFZDRGYrN0FieGhJV3paNTZENWM4R3Jm?=
 =?utf-8?B?RUUrYkV4VUUvSzNDQ1dzOVNBSVk1cG9oVzNQdDk1YWY0cTQ2akNxa3hZeVRK?=
 =?utf-8?B?TTUxaVJuVFE5aTVWTTI5ODBRWStDb01PWWRxVUt4UkdwaTN0dkRMcjlNdnVY?=
 =?utf-8?B?VGdYY3FnQzlZd0djenB2ZXBQbU02aUplMGhXblJsUjl6UFhDM01EUzRxZEVJ?=
 =?utf-8?B?dXBCVEtCMmgweFVpa3BLZEdOTXBuZ1pXVTNZeHRpUllLNjhqVzJCazJ4ckpH?=
 =?utf-8?B?ZW5PTmp6Uk5iL2thM1ZQb1FWYkJNT3NocGFYcWNIc09tWThZbjRmR2JsZ2lF?=
 =?utf-8?B?R2J2cHE0UlBaVXdPa21FWUZRcGlpS01VbEpNZXdUOFgwNHlMZVJFZ1JHZGll?=
 =?utf-8?B?cjV4M2hEamtCM1Z2ZFV1dXZBVnJ0bUQyOHZ4eENMYzAvM2NkSnpzRkNVYUdO?=
 =?utf-8?B?ZkJCMnI2djRsZ1RSVldkMG1IN2RGd0NmYUVYQlptY2lvWld2andUZG1iZHdH?=
 =?utf-8?Q?QBfNzMSvnx9Tn0UXwdEmefac9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4be1fe9-030f-446a-805a-08dc06c5aca9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 10:22:06.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RIDzWp0aLK4i/hQjvoZe8zPQ+RTwUelaR/8La/56SVAcZx1U3jEwnPtw6ceW8O4QJPW5Xt3dQ0a6ITbXamlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------lxPAFsUk683YwtV710WulH21
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please ignore the change for "static uint32_t atom_get_src_int", this 
doesn't fix the warning, will try to send updated version.

On 12/27/2023 3:34 PM, SHANMUGAM, SRINIVASAN wrote:
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/atom.c:316 atom_get_src_int() warn: ignoring unreachable code.
> drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring unreachable code.
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
> v2:
>    Removed below redundant code from v1
> +		val = 0;
> +		break;
>   
>
>   drivers/gpu/drm/amd/amdgpu/atom.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 2c221000782c..10ec7d75ce7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -313,7 +313,6 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
>   				DEBUG("IMM 0x%02X\n", val);
>   			return val;
>   		}
> -		return 0;
>   	case ATOM_ARG_PLL:
>   		idx = U8(*ptr);
>   		(*ptr)++;
> @@ -395,7 +394,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, uint8_t attr, int *ptr)
>   			(*ptr)++;
>   			return;
>   		}
> -		return;
>   	}
>   }
>   
--------------lxPAFsUk683YwtV710WulH21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Please ignore the change for &quot;<span style="white-space: pre-wrap">static uint32_t atom_get_src_int&quot;, this doesn't fix the warning, will try to send updated version.</span></p>
    <div class="moz-cite-prefix">On 12/27/2023 3:34 PM, SHANMUGAM,
      SRINIVASAN wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231227100417.3504719-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:316 atom_get_src_int() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring unreachable code.

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
v2:
  Removed below redundant code from v1 
+		val = 0;
+		break;
 

 drivers/gpu/drm/amd/amdgpu/atom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c221000782c..10ec7d75ce7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -313,7 +313,6 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG(&quot;IMM 0x%02X\n&quot;, val);
 			return val;
 		}
-		return 0;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
@@ -395,7 +394,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, uint8_t attr, int *ptr)
 			(*ptr)++;
 			return;
 		}
-		return;
 	}
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------lxPAFsUk683YwtV710WulH21--
