Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9931FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 08:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421F810EA80;
	Tue, 28 Apr 2026 08:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1dbd1Pz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EE310EA80
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 08:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDPmA6b/yeo8ljOv3NpJoptG05Sz5ShLVOKw5WrccaTPnrV9Io8XdN1bEeEpZ+F0P3g61c01jx7ZDCoyNPiYlKXEqqbtoC46cc+RVp9g4bBf7uYgCvVsGvEdBA3gWs3wiaFdgd/V37QZn2pwgYnSDGDtcAXv+/370jMWvVe442GN9ZhnV8/nKao6tN9wvKD5HEw2QEfaqf7rSLajDATq284qdxGq5FI6sWcbToh9+e0f23KkkTCRje+wv0Qy8QTUEMCC9wa8pzpqU/mMKstETe/S18bL667LHDdgnDAqX0HxHUsC80k3BSA5uDEiQOVhELbUqsSTCZNzIS70FnZFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN5R0cq+nnboEbxIo2fGD7lOz+/z8WdKu77vAxC3/1k=;
 b=HzXL8tXB8S+uprzWgw9kDpsWOO41UB286/NjJRnWuHGa06Z/JETDANmYAj71nMbtoc1qwLiLk8d2CkafmBec9SAyaPIywJLhZ6HcsebZm+oEKr+WaY+ak6FY7jJix8iJtw/2GX9/FQL5miEIi61FPZSAaN8EBS2zd31GLiPMq3456zSsGrPcCHsQNJYs6dI/bBZMxIfoE8sistJObu+u6WnvTwvTcRFxtWgf2YpGrOj7JHvt/s+lgItP2tsm2Fs4Y+0eLhhCNjzo6jeXXRbfLdUQxHVqy+eZWbg6Mt3ZG2xKEThwzs+XAvOlhJK5XnjHsRjzzJby/3WOcrvMtUAKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN5R0cq+nnboEbxIo2fGD7lOz+/z8WdKu77vAxC3/1k=;
 b=D1dbd1Pz5ev+mTzS59wA7lIkR/JoviEHEB4Rr4XZaaTejodRbH50CJ4meBUbDFwcedBgiTPbazy8KtIgfcmmRPdkn8FVSiWRA7eHqJUPFFDEqbIZhWpIeek+Man9TldPa+2FpxGQ78z5EKizIndpkTmAbSJ8X9gdfiOv2TQhEqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 08:03:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 08:03:23 +0000
Message-ID: <78ba0927-1b65-4c7a-95e4-e15a530f5552@amd.com>
Date: Tue, 28 Apr 2026 10:03:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up the userq unmap error handler
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260428021331.3730918-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428021331.3730918-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a9cfc-0d55-467b-696a-08dea4fc9e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 56a4/2ubu1WHCV8Y4wUa5KRugUqvGdZAOJFTFrDp9IRT0RtjCpgmMCdR6tf769kzhoUKy0nycor6jgAb/VQ0RCakwcyR1qhSw1v47jxyKVkk6wjQpvoi5MiMpXAEcGK0JKb9pMZsBKj/4ECaH/9Ru3ORmUG4DHDCOmwF8AD9OgCoKAOMYILnBFKxUtm3vxXuhe3SDy6ZL91ANFtMRe0ie+V4+gfksA7UVeIyXct2i4aAqhIAUiTDrr0aMgJyiwmAGfv+ExDzMbYWFTRMwBBvUzF7DuoZmi47Z59yxnZNxv3E+PoeCbP9tglE7SmJI7Cl44GQzMJlJ1OErAzzecuMNfAPaldlIUOJ2+ScoAKK1ZKIB/A4oCR+kNm+HNz+Ibmu+XW6ay74LbQpAg0uCK8dJK47NJHgHWoGVumS78PgC7IlUII3jZUEJ5UBLCQcnKvJNyt7UhHOOPEYdngmXznENwdGxB1ZYcuw+1DqPW6zPTP2hD5gsM02P77ZWtAOfMMmSnv7AF0oqjAUpfw2vV0j9Po4RuEPViwOO4QXe1IkEvZaOG5+evIl3OenGBqZ93A3rZ0yGAx4cMZd97cXID4n4gUHDXszgRPKdRkoksmWxkLQPaAxtkGpq6YEBjdZOXxclzyG8eH580TC3yixFtAMt7qU4jO/E+bswXS/qjVBNk6T9eLsISO9iBMDnJOeFgm0wH1ozAUkVot3IsgI8X1q5Ud3ZIC+yNjyEcDouH574jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emF0cmF6Ry91d2s4bVNHbytaSG1va1ZyTkhnQ2NaT0ZGWWxuZDZrMFQvUFpz?=
 =?utf-8?B?UVhHQm1PeFlvajRuTVh5dnNOaDBIVG80T0RaTzI4Yk50VjNVTmxRNnc2bU04?=
 =?utf-8?B?SHhldkk4c0ZTa2tvcEtFWlBPTXpNekY1bGVBQ0RkUkcxTzJub0kxQVg2RHA0?=
 =?utf-8?B?YWJEMnRMY05YZEFVaWg1WmJEdjk2elBSNnlkRGdrL2xObTJLSEpCcUdsVHdz?=
 =?utf-8?B?M3UyekVHOGhjc1FHNld4R1JGMHM0S1lYVCtTdmJIcjdDek9sWXJZbHozUXRU?=
 =?utf-8?B?K3IrUFpMMENzajgyYXRSemlybHpaNGl0Rno3RUlLTmRxRUwxWFByS1ZiVHhD?=
 =?utf-8?B?eFpHVFVWMmFCbDZtYkl6aFg4MDFqUFBia1A5Z3ZCY2ZqUXZZUlNBS0lnQ0p2?=
 =?utf-8?B?ZXkyVEg5MUhhOGlqNHF4NDIrUWk2eHgwaWRqUWRGeVV6WkN2cHJvNXhoZ1Jq?=
 =?utf-8?B?VFhjcENaNk5PemZnTm05Vm1xczF3TWpSRmt2c2ljNG8yZXhsQ2cwS0VXVWJP?=
 =?utf-8?B?YllPNnZDVXh3MTRGaEhxeFlDWCt0WDlmdjh0cE1KY1NFNUJ0VGdUYmVtUGN2?=
 =?utf-8?B?K0NwRng1dUpzY3lIU1dIb0F6VzVKMzFaUFRuL092MFdqZUdSY3pwd2JORUdt?=
 =?utf-8?B?ajFUNzY2RmpiR25JcjdnQWphN1QwaG12OGVZWjBDb0xIRWhUbmZvM2ttamRJ?=
 =?utf-8?B?WVlsTUxEb0xlTXgyVVZteUI4L3VRa3prTGN6VmdycEVWdUJRNGdyWktWNlZs?=
 =?utf-8?B?S3pDN2dSdGdkWldpZ0F4blRycCtOd2FqREk0M3k5cmY5c1kzQVMwUVZhbFhQ?=
 =?utf-8?B?Z3dYS3JkRkhpTlJsNjhmT0Z6VjdZNjFUaENURUR5SnpjSVhKazhnSUpiTXFG?=
 =?utf-8?B?UExOSUpkQTArZFNYdm9vYitzRVgwNFExeCtvTUcxaHN3bmp6OWhwYkVFcnc2?=
 =?utf-8?B?Q0c0dWVXcmoyZXJGbFJFTFdOZEhSZzhaOTczRnA3aGdsM2tVNnI1c0cvTTV0?=
 =?utf-8?B?aytodFpyenk0Q1RIR1hjZW9uemp1d3FDRy9yTXYrOVNMaUFXbDJiV1hGbTBE?=
 =?utf-8?B?YzVNQTV3K1Q4cGhuOGs2d0pqRjRycy9UN0toU1hBa1FidjArc3ZpZUU5dmRu?=
 =?utf-8?B?bk9CUjd6SWxWVCtCT1hJL1dqaG9hR1pzUDRxUGk4bXBUR1hTakNKRTFtek4y?=
 =?utf-8?B?SEYzVDlFeDV6bW5PdlpIbHlEUWQraWYwa0NvSW9tWEhXdDdxRkorMnlpbTlj?=
 =?utf-8?B?ZmlOdERNVklkYldBczBGU3ZQa2tORThDMmFwSllscURKbGVGM2pRUmVkYkZS?=
 =?utf-8?B?QTJyMjk3SmNKSkRLR1U0aEZvVE96cVByZm5MSHJMR1l3MUpFZURZMzhrTUlD?=
 =?utf-8?B?K1psWVl3V3FCS3ZGSU1UQ1A2cTh6OUVCcnQ4QTZPaVJlc3pVcGx4cXNPK1R0?=
 =?utf-8?B?UXpURnJwTXpSQjVud29xVTVWL1hzb0EwRFU3QlhFY1BDWnUwS2ZoN2l6R3FO?=
 =?utf-8?B?VGg2VGYvOVYvR2p6RWRYcWlGVTZEdGVVZGh1c3Bnc1Z5N0lPa3Y4Q2xlU1V4?=
 =?utf-8?B?QVFaclJvUnBuNlQ1KzdseWFURTFSMWI0N0JkdXJTNGxmeTFSRXZSeHl0T1hK?=
 =?utf-8?B?a3ZtL2FsSmJ3UTdNMmZBUXkrWmZPSkszVHFLZkRVck5RaHU0aVprcE11a1F1?=
 =?utf-8?B?K25Mc203VmFaQjJoSVdvZTY4SmJrd3BHSEpRWnRuMFhMNDJVT1d3MFpQcEdt?=
 =?utf-8?B?QzZUdnQrY1V0YzgybVZyampNQ2Y5NFpldE1BNHB2Q1FqR2lnV3hZcjdZamI5?=
 =?utf-8?B?WFVENklUYXhMZm45KzhDV0cwNWp3Z280dzJjOXhpckJmRnNHNGtWQ2pseTJG?=
 =?utf-8?B?d051K1lLbVBFa2ViUy82N21JZFZ1YjgxRWwvRXBhTm9wVXc0ZmNSbnZZaUwx?=
 =?utf-8?B?dnN0SGE0Y3RpQzlZdGhTWWFjZlc5Zm93alZXdG01dlRvT1kxMVQwcEk1Z2Ns?=
 =?utf-8?B?Z3pianJoNExTUGlObVluZW03a09JQ3ZOb05uMDlVZ0hxY2kyUHJ3R1VPZmIz?=
 =?utf-8?B?TS85VlpLRUE1bTB3ekpZYm9mVzlHZUUwWjdOTTdNY2RsRjVsR2Z4TjV5UDlD?=
 =?utf-8?B?MTZwMjFxRGdZbFhvL1dkMzRaNW1Bc3R3NWozb2ZSbXpOdmh5Y2FtdlBLVEJk?=
 =?utf-8?B?NHlZTDJEcFl0ckVSRDNmbmVhUUpJZ0l2Qm1aaVZ2RVRnbW1EdXlXSFhhUWxE?=
 =?utf-8?B?dlQ4OHpUQjN1emNKV0FCOWNuZ1lWTmdTYlgybTlzWnZ5dEVUaFpnMDR3cEp0?=
 =?utf-8?Q?7QRXRr8JOCrehsZ5FY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a9cfc-0d55-467b-696a-08dea4fc9e4b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:03:23.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Dl4x3T/eQxfye/oD0rxa8a1iU+/PHX+B+267qg8sZOE3vCWtmt344+1dVYrtdKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

On 4/28/26 04:13, Prike Liang wrote:
> amdgpu_userq_unmap_helper() already handles the unmap error case.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 58b9477c0346..a6cdc157b402 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -656,12 +656,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  #endif
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	r = amdgpu_userq_unmap_helper(queue);
> -	/*TODO: It requires a reset for userq hw unmap error*/
> -	if (r) {
> -		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
> -		queue->state = AMDGPU_USERQ_STATE_HUNG;
> -	}
> -
>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);

