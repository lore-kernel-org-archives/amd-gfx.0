Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2524C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A03F60F46
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A03F60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2BC6E1D6;
	Tue, 19 Oct 2021 18:47:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087AA6E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFMffqB+tvnYsMtBYT64bH+L+oGb0NG3T72D0hTFz2Wxqhi/fAmrJqD2UzL+nf6t8uvJRf87A/BWVWGlwo52TzpnOAHTtetRTZ7JHYtIDw5sohwSXD3H3k/iVWQdY9j+9m+rKHGEA6Jl1gGy3VYazQ72extNCHmidGc9KFRgdg6j47HoBt35u6HAyMv5OqOr69G21DtH+PuOqfl7+mQu3RWHROWfTp0OGN68XzmYQP1k0KyiEpZhNRFXJR430F1QHxVFZC3F1VNaPsqDAHoXVZghmIUBs4vCBB9A0n+ICcMMuy49OTWtKdb1oEB5FOetTBtGoWbRcd2mGlkJHF1OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVmM4Pc1kcYA9NmNCgumhPSDJWYNOhIjwQk73XetYJQ=;
 b=dA76VnkymtE86mHYRi0w5Bd2DM6RRz9zqly460qhIcqaO1ST5IoPK1JGNUgmVgz02HaYl8Kx7GsnrKpMa9UM03mOORyAdece0blEnwXO6dbnZj4tM1GURJkhtzPSQccLIHQOUnnx3H/mSpnIJx9485x4pay92dJV+o+HkfEIpc4zJ/6rxCRJcOBCmhCudhYg+WsGwsjzPZZD0eEPKbzUDi/RSFDg/AHhnsri+fF1+wXIeo6Dsyem9UJZTIF0Cfo4J7Huog8+5XXjS6m5GObUZHnT7B/av4py9wb5JA4IkI6ErJ3Nr6QbFedAfCitxD1ecSSjLu5bxt82mgNXKUPm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVmM4Pc1kcYA9NmNCgumhPSDJWYNOhIjwQk73XetYJQ=;
 b=lgKD1PnoUN0xpu2ueNTu75Y0xT6+oOf5DNTsSO6eVo8qJ7hfUOXdv9beTtkjkQE51cwqlQUB8LlP7lAHIBo+hh806v1vNwZokanfI6VgYcwFqqyXSIYIMCzsojj13xgY/MwDxYaTNUG7Vq9NKZeU1flTWGnr2tOLtbdyo6H5Zio=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4777.namprd12.prod.outlook.com (2603:10b6:5:16f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:47:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:47:07 +0000
Message-ID: <2ae6641d-2ec2-e330-b6e3-7d92a6b74d01@amd.com>
Date: Tue, 19 Oct 2021 14:47:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/4] drm/amdgpu: Clarify error when hitting bad page
 threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-2-kent.russell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211019175050.934527-2-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::34) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Tue, 19 Oct 2021 18:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3790c4f-a82a-479f-cae7-08d99330d9aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4777F64052F2B97260A9DDA799BD9@DM6PR12MB4777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qgun1bvF/hxQShU/uhsJcQUZKjLwKOmgl4iu7hcPsvpJ2A5DdqXu6nhaNh09y5i4IBx0YOAe2ojY6wVV7kZIGAgn+/AaZ0wDPJhedZs+HjnddPSFA7Z91AcaBEZowdH+BEDRSqA2UVLGXLxJ5yQwWwzizpFUqtmiSqhIBE2dlmwf0/BHgAAooFS2dFngbLlbRwybMo/uTuS9Jifzgcfv2uOkeNbqZgJAtOfYuzK+q1/U/2jzBCc1sRB+CAwdIPA7IvOhjI93l9EVVoRapBKU+n27CmV5O3pvhHNx/NZHlQu+uRnWWRqYcZ6J7okTPSNsZCenI5sv5+enelRFBeRokTcXkmc1UU65c7Nib43m+4YUCbYME8kv64D9BFYRYuDV2eUOgFA1FhsTer75Yu2Aeo2vKf1VUHIrihIymHU1TU4CbiAXZ2QuUiFVZl6cQzPwApmPLRJTJ/yEdOqIhcoa0zuLdnAmvzo9MDowiXUJVdTFV5loAEkC/DJPGOATRm5izDe51y7K1KsLDVzrpf0D42GA/fjBhcvZaav7p+Idn8HmFj5Un6ZROwDlzFk1mt/1tjn+xFhYtbH7p2hM/2r3St7ccrgntlc8mOW1qmQrMd53KqA5fHoAyxDs6zH2xcUm7pFElGw9vwoaL/2xD39es3qO7uggLd7LR9L3yI1YWixbzi1RxAKmwhYHgGl1QVp7+AuaYCbEFkAypYmmUV2E8NnZnWarBcu5BuFsYssGB20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(6486002)(8676002)(5660300002)(83380400001)(4001150100001)(53546011)(36756003)(4326008)(26005)(186003)(8936002)(38100700002)(66946007)(508600001)(16576012)(316002)(956004)(44832011)(66556008)(66476007)(2616005)(86362001)(31696002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRKQXZHZXR0VDE2WnRVb2QzUTZNNDdOckliSVN4aFUwMmsvTTFlYklMS0Ux?=
 =?utf-8?B?SjNDWnRpbE9rOEUxRWRaZUg4U1ViazRzNWw3NkhMRjVvaE1HWWF4UnExUUtj?=
 =?utf-8?B?RHpYLzIzL1NaU0h0dzcxQ0lOUUZpLzFjeUd4WGRKZFpEQ0JsdW5OdUw4U01K?=
 =?utf-8?B?RURaL0ZZbEh2bnRndGxlOWpzMWVWMis1NlA5bitBTnZ1UkVrZlRoVmtaTFN6?=
 =?utf-8?B?Z1hZQmtCOG5MckRYMlM3Z3dYaTRhcHNtRGJ3TnBwdW82YWwvQjZjWHBZczlo?=
 =?utf-8?B?aWkrb0daRk1JdEsvQVB6ZC9KSmdFUTZMTnBpMGVROUo4ZGNxMUZ0VjBHWEo2?=
 =?utf-8?B?WHRWSjdyak5vV2ROUG1DbHNjUGR3eVJlR3BTbGtxeW5KUytOYWRWL3pFN0Fw?=
 =?utf-8?B?NVUrMUZ2Y0V5djEwUkhZd2JvUUdkelJQRHNyNHFjSkR2QTV3NXlEL1VleFhj?=
 =?utf-8?B?SHZsbTF0RnJWTE10K2VuMXlDb2tlU2o1T1BQQkRnZzVwNHVpNDY1NldZRXBD?=
 =?utf-8?B?Q3hpc3BuREIxc0lpSUdmVm96b0kyTk5ZS1g4dWVhRm5zSUJKRUhsT3JrZGg4?=
 =?utf-8?B?NlR0RDlnT0crZ2tMZ3RPSkpQdUxuTHF4cHNhMitYVTNZVjFHOE1FcGg5amNI?=
 =?utf-8?B?UFBaMFdLaU52WGdWWkxrd2tJbkNOQTF6amNKKzRZTERYbzA5aU04SThxOUo4?=
 =?utf-8?B?MGtNODZERlJKQSttdm1hMnZiR2ZiZmduU2EzbEY3MGFnbk1BUVBGVEVWYlJt?=
 =?utf-8?B?Z2h5VzlJQjluam5lUTRHTUtDY1RhQ2VOR3M2a25rYThQTUNCZnkyWUpkV2V0?=
 =?utf-8?B?QnFUMTl5Nm1nejNpekZ3cXYzVUNHc3FpNFFTTE0vOFVGVzErWUUzRGozVDcv?=
 =?utf-8?B?RTZBUDhiZ2JVY3FJYmRYNUxrQ3BKbktPc2llZk5ieU1xcDlJcUliNnplTVgv?=
 =?utf-8?B?WmpaNHdPYnlIS09wTDBoS2xjWHZZZXZ2UEVWN3NFUHBqYlJzMFJYZVZudGpi?=
 =?utf-8?B?a2psZ25Va0ZYWEpsYW1BVURNQUV2RUo1RHdqRk9sUWo4SUpyTU1uSm1OVUZi?=
 =?utf-8?B?UHVkSE5BWGpFbTc4TGdyVDliN2x0ZkU5cS9zeHJ5WDJPVmJqeFhBU09CeVBh?=
 =?utf-8?B?aDlqQTlzZUJWZDl3akh5Z2FBdzNScjhEc1pUMko3ZEhVRkJMeDVRcGlydVdx?=
 =?utf-8?B?WkFYd0c2Y01tbEQwMVpyZjdDWjlxNzdFQXAvQUVDV2JOUXlxZ2IvWis5aDZQ?=
 =?utf-8?B?TnliSDBKbnUwRDAyTnFISzF5Wm45NmpLK3NZMUlkWHRxS2pTbURTUUZUQTdR?=
 =?utf-8?B?cEllZXVwRXZ1VVJPL251cmo3dklUcFhUeVRJT1lMV2ZETmlnQ08wZEVpaTM1?=
 =?utf-8?B?aWFBWnZkY3hQaVJJMjI3WGhRQ2x0UTlVNFlSU3hHbnI2TXFIbEZnQ09hTWEz?=
 =?utf-8?B?dnBqY29NZWhHK3dvSWVSd0dwWlhTcE82YkVqNFpTdENZN1phcUFzdXg5NlBh?=
 =?utf-8?B?a3JMZFNjZTY2ZmxFLzFFQ09UY1BrOTZSdGZYSXJuMFFSS0tjZnR4TTk5NmRL?=
 =?utf-8?B?US95aXNhZi9yVzBEUWZkMGFSY2U0VFA3VWJtSzlLZUQwdFU4TDNXeCtBekdC?=
 =?utf-8?B?MGVjb3g0Zk5reGtnWjhVK3FKS1Nua216bklmQjlIU25oOGVjYmRFRGFONmk5?=
 =?utf-8?B?ckhEaVVwWFVFZjVFU21rMHhNeXFGOFFHeC9OWGU1akc3WG5nZ0Ruak1rUW0w?=
 =?utf-8?Q?C4UTsHfmOpJWsWhbsQaINMQaX0lEAIIOZM78QJq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3790c4f-a82a-479f-cae7-08d99330d9aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:47:07.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4JDFMOCX1TEoAwiJ40t/bzZv9H7H0/T2CT1frHvizWe/onKmc5Lt0bCoal8u0rX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4777
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2021-10-19 13:50, Kent Russell wrote:
> Change the error message when the bad_page_threshold is reached,
> explicitly stating that the GPU will not be initialized.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 8270aad23a06..7bb506a0ebd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1111,7 +1111,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  			*exceed_err_limit = true;
>  			dev_err(adev->dev,
>  				"RAS records:%d exceed threshold:%d, "
> -				"maybe retire this GPU?",
> +				"GPU will not be initialized. Replace this GPU or increase the threshold",
>  				control->ras_num_recs, ras->bad_page_cnt_threshold);
>  		}
>  	} else {

