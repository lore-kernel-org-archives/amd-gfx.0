Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492DFCD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 12:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C398D10EC9D;
	Tue, 19 May 2026 12:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkC5jmpx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35E410ECB7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 12:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcBwkavhVVQKqXur0k5hI0WFX58L5xAKahmT/TV9tGCDjaXpJPj+Z6rQtpCuKvZ0Gly1Yl2cAe7hMTmOp6g7OkLDMVKTtW2+LFOkO47Urnz1tH1Vt2mCXjgb/31C27Swbqd9cYtK5H8cEfej8XNmc1ZJX2BqxZd7L4+iuO48GyVnRisEdzidhRpH4O/Dux9WRplTvAneFWS2KQFi5k7rhOB0Z94Mhj/XyzEWZUbSSwr4RaiM+Svq1eP6WEgXjq+peqKf1uTGMArOajLS6MTWzjBM/zY5+7NZUskJEUMm4JK5y80rQys9R4AoLMwpJ4m2v54U5Z0GOk1MO7W8vytBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D56xAmGKIRqbSdpSv/1m1ey44VMb0qI9egmmdFgEqKw=;
 b=WIcKbLzgfHTS09/u3gAm7tXYB91KDz36+afl0UXniwO23KREXjpSqzdvc8kwyk5RPwPhpGTrhaB2kgiPoXDraPRVdZn72+148Gfb9Gdc6KS/EMyviQGB2P3H36Y3CvZoRX5JTQ5OWV5qyHnpEoIEpnQ+y9GwkPXF9CQ01rMvmdYCLFiBtwa2DfuXSiDWtMIgKdG1Y1NYRIOuOBFSYaMxAT3Z3RTgF2wHSWDoGRFbxs4h+z64HKvdj9nljUXaDUq7i8YMejPdnu96U1rNLM3BzD8uvyp5Zhiwjr5o0htvP4y0Xj4bIZzIcX09683ookZNQQCm2QE//V9fwHHgJAv2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D56xAmGKIRqbSdpSv/1m1ey44VMb0qI9egmmdFgEqKw=;
 b=kkC5jmpxJo29Yxgt6WUv/TjpiF8SmXhAh2gSW7Fl/KmY+qY9X2dBR3FmxaXXL+xVeL47eHuS0nk2Ei/yYihqbXpXZs9woC6Jw718J1E4JxxqYbC8ok/dh0Q5fJ+GYjYK4o21H5Hvj22JFpIiSlqWf0XD1oRhjA+fPqc6+F8Pom0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:43:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 12:43:56 +0000
Message-ID: <c0b9b588-0543-4057-82ea-fe6654917a71@amd.com>
Date: Tue, 19 May 2026 14:43:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] drm/amdgpu/userq: clean up wptr_obj along with
 mqd_destroy
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: d168864b-aab3-4df4-3bd9-08deb5a44a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: oIIJAYh3sRqPLaxUGMABwfjwfjdQdwcohlQUsrCJVTdQK4ZveBEpNtOhhbi6I7wZ1QIrgFoXrhuEZa2Dg8wDIBCfPzaUpbafTjy9grguFqgnleXLSKMYr3lj5tyaPMNw8f4My5qI8xcI7kS/zY358UrSDHhknw2bNufH5aYQ0BIPFMwJgLAke4B3pOlxXRhk2SdNOZP1N6MVq0PwSsptZ6PLyAiyaihS7xJsAGBYuny3VHiP4KEZUjqaOl38K2JcMpwTqH6wDydUqTOZUSZsQWJEn8IGgxOS2GS0qQk44YNJWw7UzCOGbRfCKJVYgFS0SEKrBVU6wzslY/Ev2DxKfjkjoHiV33rb7NJPlGR2fXCRe9a8xDPEwQN0o2PRhV4aCo2sUgZMfz/+K+ULR7p84vTIFJ+oSn0U7/U38HSigxvJ4sNDIIZQiRZsWzA1la0zxWlGd1qzM5G1wfqkl1TMzFEPEcZz0qfkt0AN34tD40eLoRCc7f5+6pHUjylRpEkY+OVaZ349CTSUIGvuIrO/Z7Vn4xWaFmOmC1+Hgz97fVpNdJBXxvFZAAgFknl1PmCGfKuqlW1GQUsn24VXo3hTLpy7OBN2ac99bPJ+jxfyr/5Ze1jiSTQBHTK6cT6DCRzM/QMGGqy8OggeW0HmQBwdsrGGIwvQ2rsNenE12rzGnUFVgd8SUixl/4zo+CgVuzTX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NTVVRMRjQwaXdjR2s1STU1dVJGVm81SDBDeElZUkR0eEloakVLS0l5UENq?=
 =?utf-8?B?SHhobFJJR0NrMEFQWUxMcUdOb2l5dUE5cDBRV1Z1clNRU2RlY3VuZThCTVEy?=
 =?utf-8?B?bHJhdTBudkhQR3d4ek56SGwxbm80SmdIbWtHKy9DM0lyalZTUldyZUtWdWRJ?=
 =?utf-8?B?TFljR0lrNFZRbWkrczhxcFJxLzlKZzZsYWZuNHAvTXJDakkwVENmM21xWkZF?=
 =?utf-8?B?M0hRRThPWWdOSnp1Ym5hQkU2Z1NjdFBBaHFDYnpoTkYwamp1TVpiS3ZIT1Bz?=
 =?utf-8?B?MEJxbllUVjJCc2FBVGxoTkpmdDhoK1pKcVY1VlU3dUQ3UXhEbTVhRG1PYTVr?=
 =?utf-8?B?NjdFWkxrWFNzVEFKZkc4ZzFKZE4xWEx2UWhsajhBKzg0eHhHcHE0WURaL1ZF?=
 =?utf-8?B?dzRjanNHVmFDRDZ2d2JrQUtYM1ROMFlmTE14K2g5NjdUM0ZSWE51SHF2dWdz?=
 =?utf-8?B?V1lvdlFvT2lQOWVhL0tmK0hmY1d3V2FrdWRPbXhZVENKZzl1Y2NvL2E5dnJM?=
 =?utf-8?B?ZmlTRm52SjNJdEdqbzBhdHN5L24rUjVVRC9KdU5nQnp0SVNKMXVhZVBLa0Y1?=
 =?utf-8?B?bVRlT3B5OHRzdmwreWN4TW9sa1BnZTVNTHFNZ2NyTzRiM3o2YXlxYUNWd2tU?=
 =?utf-8?B?RXhCQlc2Q0ZuNEpMZTh2dVQrTVplcDVUVkFJWVdFU2h2TStjMzlxRnpPK0N2?=
 =?utf-8?B?K1IzSGp5VVB6NXN2R09kUnorM2loMXd3YWdpNy96ajYycnhLd1dsV2c0T2tr?=
 =?utf-8?B?ZWFiazY5Z1RDTXpSSXk0cWVpc3Z3ZTlMRWJjVWN5U3IzWmRvdDFpcGQxL3dR?=
 =?utf-8?B?ZG5uQ0p3bTZFUVlXejhUNEpqRzJGTTJNanpwYTZqTm53TVZNVWh6UjY5OXUx?=
 =?utf-8?B?SVpwTDFRMmZTUHJZMFZZZ0NudTBIWHorQjYvaTN5Ky85djRGNGx5MFUzZlB3?=
 =?utf-8?B?Skp5SmYyU2lsbHdZd2dEb3lYckxKUjh0ZmJqaUkrVTA4OFZtd3l2YnZybWkr?=
 =?utf-8?B?V1lzaUM1N2J3MjV5NHBYd3k3SXpwZEZuS0tKNWNCejlxdEltT05UTklHbm1r?=
 =?utf-8?B?OFYybDU1ZkV0ZG1Zb1oyMUlBbGt3dTBXMXNpT0RZQ0hESnhaNUM2R1N3NUpq?=
 =?utf-8?B?NkEwaysydlU4eE5OSEFjVGo3VXV5RzVRZWZ5VjltT01Pc254R2lUdVVhNGg2?=
 =?utf-8?B?a0Q4dzdIeW9zdUM0UVljeGdBendNaFd6NDM5RFNCZkd2cnpJY2ZPcmhsREs3?=
 =?utf-8?B?T3B1bEZqZTBEUVN1VVlkbE5Uem9TSVpBRFFDTVJsZk9KdUdPYncxRXRiMXBQ?=
 =?utf-8?B?alJDK0NMdkdtKzR4OTIyOWNScXpqUExJN3dueHE1WkUrdmVRWmp3YWJ0Q3ZX?=
 =?utf-8?B?RkR4YmYveUJHSThlQ05CcW1WN2w4c2l6Q0xOa1FPb2hCWEZYaVFVdm01RW5Z?=
 =?utf-8?B?UGlHVloyWHlVNGN3SHJhUC9WR3lwSUEwUHhyMGsxaXRFRWFZa0lGT0JzN3p2?=
 =?utf-8?B?YlRaTE0rZTdNZ20wenRlM01WN1MySnA0dm8zendjNXBWMmkwNWFIRERVSGJO?=
 =?utf-8?B?NGdjMkhUcUdCR2hhcHlSc1R3UWJ1RXM1cWFwdko0bTF6YStOYW10M2R6NkF2?=
 =?utf-8?B?MDV2SWZZVEQ4YlN6OGpqRXJpL2ZtSjBhRzNiYkRyZ0F5Mkw1Wlh3NjE2eXp1?=
 =?utf-8?B?aisrMlg1RkFmb0pyZmlxUWZmYXRJdTFPd21MWnNtbi80NWI0K0pGc0xscito?=
 =?utf-8?B?TVQ5Y1RDejk4eGZXbGRmQmJlTlV1Y25sanphTWlWRDB1LzU5Q1Iybm9vQ1Yy?=
 =?utf-8?B?V3o2bXVIeStmT1c1SGRUK1M1eDJzUjZlK2czL3hMMEk2bFlLVXoxckZzS0FN?=
 =?utf-8?B?amdnZHFQUFNNUkZuQmJVYkRGK2REaXd6QlNLei9iOS9FREdQZmxrenNlLzJH?=
 =?utf-8?B?MCsrdG4zbHhSb21LMkFrNVlmL3Rvc2xSL3V2M09pRVpaN1pRS2xWV1ljMDVH?=
 =?utf-8?B?endUNURLakhETDhPZVVzdDgzNEN6dWZqL3RCaFUvVTRkei8xTmlVTjFINUM2?=
 =?utf-8?B?RkIvck1aeE9XZkdDMnhFdDl0OWxBOEo1dEtGY05JaWNJWXR3ZGdLSlh2Y3JU?=
 =?utf-8?B?Rmw3bEw4eXZ4M0dScDF5dklQc1RkWW9wVGRYK2lsSXhzemswRUpsa1lOS3Yz?=
 =?utf-8?B?L0hRNURTZ3hHZ0ZpVmRpS2lFNUxjU3VQbmpRWGJwUTBOT2labWtmcHN0YnlO?=
 =?utf-8?B?dnptYk5IMnI5WUVqcEZFcDRBVTVvR05NckN4STV3ZWpkeXVNYkt2MGlvRmsr?=
 =?utf-8?Q?f2VvoMr3FxS3+hIvQk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d168864b-aab3-4df4-3bd9-08deb5a44a82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:43:56.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZXcoVb1YKiH9XDqMu2R6DgJQZPfcBcgmKpL97OmNQmGqQJyz8QNhhWpYc8vHh7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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



On 5/19/26 13:17, Sunil Khatri wrote:
> During queue creation failure, when we clean up mqd via
> mqd_destroy we arent doing the wptr_obj cleanup and hence
> adding that clean up.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0737636fac43..47a38fefad89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -835,6 +835,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  erase_doorbell:
>  	xa_erase_irq(&adev->userq_doorbell_xa, index);
>  clean_mqd:
> +	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> +	amdgpu_bo_unpin(queue->wptr_obj.obj);
> +	amdgpu_bo_unreserve(queue->wptr_obj.obj);
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);

That should probably be a function in mes_userqueue.c instead of here.

Regards,
Christian.

>  	uq_funcs->mqd_destroy(queue);
>  clean_doorbell_bo:
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);

