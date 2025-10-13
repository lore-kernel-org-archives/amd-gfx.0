Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0088ACCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0EB10E105;
	Mon, 13 Oct 2025 13:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wz4rC1Ff";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EEA10E105
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3BhIPRqQBNglqiHzh6l/QkCVWgENiKk0yUKTcp0qDjI7guE81L0fHUk6G+wu5t6EAM1ikP7FgVZtDA9/tR5zNzAqwJQTx4ZEPiyFfHvlNq/mKndJm/saAH9jOyEhXmnqyIA0T7x7nPV8hR6fkHVeNeDg45044AT4Q7t0zzItfvLVVFsALuIJGvTCacy8WkH6cbaRTbeBbM1a6/nbveeJDCGYq/kUuVOTK8hwizJCLu1BhSr8IKqhfpcShPm/RQlAz/gL50TbbMcewtPMqKlAcfUnsc3ThPfTG5IknAMklGo82wA5+Sn/qB/vT9dvnXhaI4rbQ96aRIUFVufPeOowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLzg5/YxBJiX//znKVDLUltTJ3VwNVNtes9mSvUQKsg=;
 b=Lm7eC/D8yzg6EtcCrHfnhctdAUGvwmSQ6ktrRJH5ZiRjpHWIBGp3roVZMJgl4nJ6Zj7g6rFtcyzxI2NfTIjJN+HkKgO9NCcKOHn7iX5+YaTymj8fBzwB1YnbiXrwBnsNFdj6fk/VDYc+9aWfpwSLFEiIfN5D8ITRlVrTD0PQCOd2otIgzzgOFBqsfFeXCQQU8K2aGaixabrwXKpnsgDJ6ihqRfBwgnck3oAfpuVOd0d7OpbrmNod9kIN6iqfliRZbaPQWhOyxcTKEC+hqH25AmOacEAatbSb+pbQPkwHrYp0hqVv+qeCQxu3YUjtiDPExr3QnePVDvm7j+XjNAhOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLzg5/YxBJiX//znKVDLUltTJ3VwNVNtes9mSvUQKsg=;
 b=Wz4rC1Ff73DyK1dkvxFMr23ESsalAwafmirCpyiw0qB1PmEQQFDZd4R7vz1Z5W1cVtyAxKIaCXpp0jNpaHa1jHTmOCUQVMR5R/wqNeSCE5ZkTgK2K6S3+ClIBhZm9VUD6PYYpxqQqzivMC8SqZJ30E/Vl0RM56ZDRwLENDAlNJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 13:13:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:13:00 +0000
Message-ID: <6b1b9e23-ed14-4dec-9369-e7f96bf257e2@amd.com>
Date: Mon, 13 Oct 2025 15:12:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE
 6-10
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-4-timur.kristof@gmail.com>
 <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
 <3b1e453fd8595afb0b4c98855a7a06ba940925a4.camel@gmail.com>
 <CADnq5_OFyAQgZdE7_u9JubGKgxTU89rJLJYwW1hMOi6be0nBzA@mail.gmail.com>
 <d214f753-21ae-4158-a9de-0459d7171360@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d214f753-21ae-4158-a9de-0459d7171360@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d38d38-8d77-4bf6-aff4-08de0a5a3c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjdQTFpmaVhPN2J5eGxzaGhhdms5aExCaEdrSXl5Vkd5aTVVOXZBZVhhcWo5?=
 =?utf-8?B?ZjgzWWQzMy95dktSbElZNmE3SFdOMmFJb1RHenJ6QWw3a29rK2xWa1FXSlNM?=
 =?utf-8?B?OFVodFIwcUI5S3UvUXZNeE5OWUh2SUJPekdqMWtWZ0RnOVE0VlRWak04eTEx?=
 =?utf-8?B?ajJpYkNLcXNRY1BWT2F0MFRLNDNEMmkwZUt1TWpqaUNwYmR1djAvVlVpZ20y?=
 =?utf-8?B?MHpucXhPazk5aStRSEVrQnE5NiswVzh6M0VBeEp3OHJMWnhoaEorUDBLOXBM?=
 =?utf-8?B?d0d0RitHSUdZeFBzdlRCaTBlMVNnbkh1NndEWjE0VzNUWHoveFBvUnhSZU5P?=
 =?utf-8?B?S0ZuMy9DQzJOVEkvak8xSkFuK1QrMFhvdmtJaDhtOTI5SUNOV3h2R0ExbDVY?=
 =?utf-8?B?MG9BeXZBbTl6M3ZpTXNQS2JIOE1aMGJGak9rNjZGeTNFVHhaaG5HdWg3SlNl?=
 =?utf-8?B?Ty9JdWRRNlkxR3IxL0tiMXFXSW14eStOTGhRdjl2Z3krUW1KcVlHZ1VXUTEy?=
 =?utf-8?B?cDJud3JiVlQxYklnMlQ0cDh3Uit6Nld5YXpVWHVCbmtWMlRtMEpGczhxaERG?=
 =?utf-8?B?cUppbjFuU3ZVMmsrc3BLWUkyRVVJaGRjUGFIUG5pUUNvVVdsYzlqZHZ0TmlQ?=
 =?utf-8?B?N0VlWktFWEpscVdqdE1FU2k4L2Rvb2xhdzNZdEx6YXJWNUZNWEpqcmJPdWNt?=
 =?utf-8?B?WEkwUXp2aDlGSCsvdlB3RzN5SDBRN0FmMFJiQUJoQlNPYmhnL0RqSGhSL0FI?=
 =?utf-8?B?cmN5T3JSN1pwclBNbkRuTHViUHV2c3ZxSnFLYTlkbVBGOXh2djdmcldwNUdl?=
 =?utf-8?B?SHFPSERRL0NlSlQ2dWwrT01DT3IxYXpBUGYvTzIvazB0Z0hOSWxuQ0llaFlr?=
 =?utf-8?B?NFBNTXhRWFJFUU90MDdSWjRvVG16R1l3bmc3Tm5JTkZtZlZ3aU9iS2xBK1J0?=
 =?utf-8?B?SU1rY3Q4dkdsUThsaDA1bUVOR1hNbGpUQ3dKd3hBNUkybnJhNXgyZ2NoNHo5?=
 =?utf-8?B?WGNXdEg0aFFjRXFkUW5VdUNENGlZWENvU0Q2OFEyYWZZenlLUDMwYXp1bStM?=
 =?utf-8?B?NHA5ZUt1Y2JMdWZDUnliUTdKaTBVVWhNak82RkpnaFhwZks2M2tWN1dxd3Y5?=
 =?utf-8?B?Y0c1N3dEU1pPbWRnWWtwN2MrbjFzaWx4YnQ0VUtIUHJ2NnhRTWJPVlU2dC93?=
 =?utf-8?B?UDJrSVVFVjZzaUJRRGQzK1VIVDVDM1hzSkJ6eXhERG1EZDJENkRWb0w2bWJi?=
 =?utf-8?B?OVEydHBhNlRxSk5ad2ZzT3FndmlYR01tUWFRNWsrVTlvNVdNbU5sZ2Q2ZnR4?=
 =?utf-8?B?WWhoaTl5UWVSSjFYYVRHcktwV0FGbWNEcUxKQkV6VTJKdmtDYzc0UmF1aENk?=
 =?utf-8?B?RWxMRGQzTVJ0QkRsN2FrSElyendDeVpjSkNMWDlBNFZOUDRVZWNiZS8wYVlm?=
 =?utf-8?B?RHZ6QTBMdk10R2F0eTFQTm5HVzU3aEgzYzlwY01lTjk3ZC9FQ1l0Ym5MeEVw?=
 =?utf-8?B?ekRCRUptNTNvZDJ3cnpkelNXMi9GT2Fzb2J6VHlTU3ExalF0WHJETHA4OWJs?=
 =?utf-8?B?cGY3enowOFdJdk5lclVCSlJYVVB5ZUVSQUpFR21TMjhkZVBnNXVNYzhEVnUx?=
 =?utf-8?B?NlVabjhnTEwyT3VpRElxencrYlNLSTZSZUVDRGlnc1hRTGl1WWxvdUNqRGpl?=
 =?utf-8?B?UVJCeWhSWlMydnRhUmUwUkxMYlp1RURyNm9Ca0tYVzlVU0phdk1UUmp2aDJ1?=
 =?utf-8?B?OWhXN09ad3hmRTF4TThIM0VMbEkzeVpuTWtRQ2hDTUFqUEkvQk9aRmJUWkl5?=
 =?utf-8?B?MzNFekxQZTBoN2IyNWJMQU1pM3BWSEV5UmdFbFBDMTdMclBnL0RPNzVPaUlT?=
 =?utf-8?B?TkRUWCs3Q3FCTGdNK1pic3BWK3FjaGVXeURYTkJ2L0F4QmRGMlI0THQ5ZzV2?=
 =?utf-8?Q?HjfDV7cuAoESz1ld2DxOMAySXOk6FoZw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZKQmtCbzVVT3dsMXhNemdxUExNRUVPVHBkL3F2bDFQWEEvSnp0VmhIQURY?=
 =?utf-8?B?SzZFRmxnWWFpai9EZDBOaGdwTURSUVlOR20rb3NzQUFhUlk3SVRUcjhKaUpw?=
 =?utf-8?B?NDdyWFFhWjhvbUx2SUFCTDFoL2NHdHZtSkVLdC9pWEduRkM1ZGVDR0daL2g2?=
 =?utf-8?B?TzRhcjBVY1JhazE5SEZSb09rYU5nOEpmaVFxODB3MVc0WndIbXBQaXozZmQ1?=
 =?utf-8?B?NitoRFpZU2oydGkyTG41MTdnWVFTSkFxNDVOZ29LdHhjYkdURi8zY1pxaTRa?=
 =?utf-8?B?Uzd3UzcyOTNDVTJnT3B4VzFiV0NNQ05kcm5udENRZ3E0NUVuYUhKYXdaczlw?=
 =?utf-8?B?c28vbW16dDJLRm16U0F1NGxDNmtkUUZycXU3dEdmRWk2VXh4ZWtUNVA4V1VP?=
 =?utf-8?B?RWpraStYRmluV2pDdDB0V2RnQTZYaUdNNDNoc0haTTl6eHJuMFFOTTZtaGtC?=
 =?utf-8?B?RUY5MWMrQ0FvbWJQVVRqQ0IyL0NDa1Z4UWI4R2NSWnZoZWFmck5MdXhmZytU?=
 =?utf-8?B?UnFmNHRPejR6cy8yTEZMUzhhUlNQaTA4RW9DcmxscGh4OEFDM1k4RERiVnhN?=
 =?utf-8?B?KythbFVjZUk4N0NmcHdLTVVIbUVwZytick9wa1VoYWJ2bGtjZXZteUVyeWF6?=
 =?utf-8?B?NUltWGZGNDJBMzcySTVuaGQ1cW94cGU0ZGxZVnQ4a0d2bERORWMzdFJaRGpX?=
 =?utf-8?B?SUV4cTRFbSsxOE9LUVJ1c3VuWXN4Vm0wQjVwSHN2Zll0MjZVTHltUWh2TGl1?=
 =?utf-8?B?RFgxbG1iaDFhVGRvTFRlWDZycXdNR1ZES3hLelJ5ajBJbWg0blh5cWlJcllv?=
 =?utf-8?B?bnhQSlNXVGpIaEFSMnBPZXplaWJINUJQTjl4ME8wNXozdWZXdHZHN2l5eFZM?=
 =?utf-8?B?aDA5ZXQ2dEZVRDFJN0xvaHNZWEhhWE5yOEZVV2F3RmhzNE9YckEzOUJOT0gy?=
 =?utf-8?B?ZU5Nem94ZnJGVkttT0IvNGRXY0hsWUJVRUFCWmV3eitrdG5pbzdwVG1yMUtl?=
 =?utf-8?B?K1dGbDcwaXRpNkIzWnFUMnBXa3A5MlluWFRtbUUyRGx6aGdRYWdQcWNhQXJv?=
 =?utf-8?B?UFZlRjJLbGp2SXF1VHlHYkNaVVR3TmVuK2laNGU1cTR2VDczeURRaHgvYzVu?=
 =?utf-8?B?N1hpakR1WUxWakI3eGlsRFhmZGZzRDEvUUI3S1UwWDZTN1AwcXc3MWJuY3VE?=
 =?utf-8?B?eDNYN3kwNFFiajRHc2kvQ3gyUFNUL1B5Q1VRdFhwZkRuWDdUZkZncDcwdmpu?=
 =?utf-8?B?ak14WG5EekZBaW0xbW9OanF4UlI0MXpidzgwRXpNVHd5dUw3anl6L1VwaVZR?=
 =?utf-8?B?OE5JTU9RbU1ENVdRT3Q0ck5CSFpNRU9OYi9IT3A2WHI0SWxXeFZGLzVHcFZ1?=
 =?utf-8?B?UTFQVDNPdlpVTVRsU1FlVnNMZVJ5aS8zQ3kwVVlWaE5oVVRCMDl2ak13eTg2?=
 =?utf-8?B?Sjg5WXRRSlJ2VHZvSy9ZUGpqWlJ5b1M2NGhMbFAwRytZa0w3YnE3UUlrNlUw?=
 =?utf-8?B?KzNVbVB0MXA1OWhUT3c5bXJjSnJzWUVSVXlmaTl2RVprZkljRmdYck9jVFhj?=
 =?utf-8?B?WnlYdzVqZ2FldC9pUDNXVHZxUE51RnBJUmhYNmJRTXNTemFzc2ZpR3Q4YWZ4?=
 =?utf-8?B?cmFndnFybExFSTY5cXQzcUN5SGR3cnN2WmY4WVVSeEkyYmNIdHlPOUdtNnV6?=
 =?utf-8?B?aDJhV0RRK0FDTnZ2Z2pUNEltQjI3ck5NK21GQWdCRnhNaGwxeVVxSExYVUJG?=
 =?utf-8?B?bHA0ei9sYTN3M3o3RGV6T01ZbCtRUFVWdHBxd2VtM2dvenFua0RQTmFubXIy?=
 =?utf-8?B?ank2Q3lmZmVucjBVUkdpaDNnRGtOWUIxVGVjUFZUaHdJSVNzbysxUG1WUGxW?=
 =?utf-8?B?RW1qQ0xJS200RTM5UExkTk1aSjl2OG9TTlV5S05iZTdEN3FzMGZmblcvTlR1?=
 =?utf-8?B?WmxZOS9KcGdBejlmNnQzNGVHV2w0c1FOUWtuQjV6OElNbEFleWNIRld1cmNM?=
 =?utf-8?B?R0dhK1lob3MxdFFOUUU1QUVBUFhxSWN2a0VwMTFxbEphWTBRUWxOUFY2TkU5?=
 =?utf-8?B?aTdPM1RwTk12elBRcTdWYlBPOUVaSVhWMWIvazFkNlIxWUxhR2JDRU5kSFhw?=
 =?utf-8?Q?ch7SjDzUMR8Qm7MX5d3EJ5foM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d38d38-8d77-4bf6-aff4-08de0a5a3c16
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:13:00.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H64tgINI6wnGVLeJHfx44ORF6MqErOe0Eh5nV70CvgUCbA/pG+BznGLIYLxk/XXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B
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

On 13.10.25 08:15, Timur Kristóf wrote:
> On 10/9/25 21:38, Alex Deucher wrote:
>> On Sun, Sep 28, 2025 at 7:39 PM <timur.kristof@gmail.com> wrote:
>>>
>>> On Sun, 2025-09-28 at 16:14 +0200, Christian König wrote:
>>>>
>>>>
>>>> On 26.09.25 20:26, Timur Kristóf wrote:
>>>>> Set stricter dividers to stabilize the PLL's feedback loop.
>>>>> In practice, the actual output isn't exactly the target
>>>>> clock, but slowly oscillates around it. This makes it
>>>>> more stable.
>>>>>
>>>>> The values here are taken from the non-DC code.
>>>>
>>>> There are also a bunch of other restrictions which need to be kept in
>>>> mind.
>>>>
>>>> For example what is the minimum feedback divider value the DC code
>>>> uses?
>>>
>>> As far as I see DC doesn't have minimum / maximum limits for the
>>> feedback divider right now, though I can add that in a future patch if
>>> necessary.
>>>
>>>>
>>>> We once had a longer discussion with the PLL HW engineers to get this
>>>> working because at least the display code we used as reference back
>>>> then got it wrong.
>>>
>>> After this series is reviewed, I can look through the other
>>> restrictions in the amdgpu_atombios_get_clock_info function and write
>>> another patch series to add those restrictions to DC.
>>>
>>
>> The PPLL limits from radeon and the non-DC code were based on the PLL
>> registers, i.e., what the hardware limit in the register was.  I'm not
>> sure what the practical limits really are per se.  I.e., if the whole
>> range is really usable or not.  I would tend to defer to DC.
>>
>> Alex
> 
> Hi Alex,
> 
> I'll leave it up to your judgement if you want to include this patch.
> I just wrote this for the sake of consistency with the non-DC code but the patch actually doesn't fix any actual bugs for me.
> 
> It is is based on information I found in the non-DC code, in the amdgpu_atombios_get_clock_info function. Maybe the PLL limits in this function were meant for even older GPUs and are not relevant to SI/CIK?

The DC and even the atombios tables got the clock divider ranges quite wrong sometimes. For example as far as I know the 1/10th handling for the feedback divider minimum was never correct in those.

But I'm not sure where the ref and post divider minimums came from of hand.

Regards,
Christian.

> 
> Best regards,
> Timur
> 
> 
>>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>>> index b4f5b4a6331a..00f25e2ee081 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>>> @@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
>>>>>                      clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
>>>>>      calc_pll_cs_init_data.min_pll_ref_divider =     1;
>>>>>      calc_pll_cs_init_data.max_pll_ref_divider =     clk_src-
>>>>>> cs_mask->PLL_REF_DIV;
>>>>> +
>>>>> +   if (ctx->dce_version <= DCE_VERSION_10_0) {
>>>>> +           /* Set stricter dividers to stabilize the PLL's
>>>>> feedback loop on old HW. */
>>>>> +           calc_pll_cs_init_data.min_pix_clk_pll_post_divider
>>>>> = 2;
>>>>> +           calc_pll_cs_init_data.min_pll_ref_divider = 2;
>>>>> +   }
>>>>> +
>>>>>      /* when 0 use minInputPxlClkPLLFrequencyInKHz from
>>>>> firmwareInfo*/
>>>>>      calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_
>>>>> khz =       0;
>>>>>      /* when 0 use maxInputPxlClkPLLFrequencyInKHz from
>>>>> firmwareInfo*/
> 

