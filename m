Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C87D0E6C1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 08:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7A410E45F;
	Mon, 21 Oct 2024 08:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whjAS8Ne";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E162010E456
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 08:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv868fk+Q7ZgUPdNq77ijep5+i0jici3TbkW4VopeZTEdb59mYifVJU77PJFDg7qnSLVhLJaIOMc89RBgLj3yt+K34V0Ibi02+mTU9cptMq/ZHEgiNnMf69IWWio8yAJJad1mOW812oqsPCNQvH8G4SCi1lcRF2W1hChcS/qCbnMBQHFcbbQ8w+iIdXCPR0uHEEcD9Sr19Po7Z5P+M6Qj1rZKOJtvowyMXkuZ+tcCAMnxQCkjE6bcNz7HsMOAzJZRqroPCr7G8cfLmtuKMbNO/NAt+Gx8EGcFziqiErNPQRw1tK3W03d8J8XugRYYreN+UI5NML/V0gDPR0GVHZSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY4aSYk1Dv1iRxUuFFbVWisOtT4cCzSHmVr1xVnwVQo=;
 b=aQ9Ij1G19OIYJS2Wg1wIXmHVfPPVrn1qA+18Omfq+6Azl3jaiI36Ya0axAZL/f2vI5G8lAnAtXmKqHktFbIk5B2nC2m8WIDaFZRDhcXlCbwRu1pz0d1X+fKoGdLpbfkYXEJTkFWpFR0o8YpYMbSbcb3cxFG9HVIH1rICidkpDnWZK4FBxIVbmImZs7Rpn6GtIIU2cEIxTTyc9CDahEnFEFBWpknYqRDH0yuLW1xxqbDaLyyfwCtgqE4BvGUNVd1HXFIz9X3353zsR1SZUiUfSKHVkkVEQ2UD0QJsjbfTT3M2RFhzo6zmdpl9A2Vj0hbMhjOiZytzKaTkBJ6Q2s+NPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY4aSYk1Dv1iRxUuFFbVWisOtT4cCzSHmVr1xVnwVQo=;
 b=whjAS8NeHZEOoWXvAaXWqIG5vL9w2h4CDvz8NzIJqb3IL5FKFsJ4QAJ34PkftV38DM1Z6aCqpNMjcUb/STjukKlT4i8MIL4Xn8JHFW5ZW0kiyEuMSDtxm/Oh/37qF/MC4aDeoc54HqTHTEH4VFsoiwgyLcxVnVabK2WMVNm+22M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:00:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:00:05 +0000
Content-Type: multipart/alternative;
 boundary="------------TgZdkK0Go0wQiUD8L09HVdKj"
Message-ID: <7cf21ef7-c43a-4ab8-b439-c845f0b429fa@amd.com>
Date: Mon, 21 Oct 2024 10:00:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: change the flush gpu tlb mode to sync
 mode.
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lincao12@amd.com
References: <20241021055644.158966-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241021055644.158966-1-chongli2@amd.com>
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8aff9d-8b6d-4d57-6e5f-08dcf1a65f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHQ5QkgwNFh4dTBSam1GMkY3dWhqM0RSdlRpaWpIRVA5dWtIYndmSmpIRU4r?=
 =?utf-8?B?citNOWo4RGtqRk0zYjJzUEU0VWYxNjdXM0FjOXpYV2lTUEhPV2VDaGFsL05m?=
 =?utf-8?B?TkZiN1RaRVVQNnBuL0hobTZUUlg3cElBQm93RGVOcGRYeDhGMWFMejNFSG9E?=
 =?utf-8?B?NXlsZjJDQWVOVDFzdFV1Njltc2Z5dTR3eDdTaEJBbStPbTN1clpTUGo0ZHR5?=
 =?utf-8?B?SEI5YVpSODdNWGRydjJDY1RxRmFEL3owYlhBMVJpWHZya0laMG96VEJWRzV4?=
 =?utf-8?B?aFFiOXJjaElKU2k3RytyNlMzTHRsTjByanVTVTNiV2Y4Y0N1ZWNGa3haenpv?=
 =?utf-8?B?cDVYV0pVeEZIVnloZmNCS2M1THlhR0pQRms4dVlXSFgwOVdMOVNaV2N5cExK?=
 =?utf-8?B?dU1oS21CT0tHbm12Y1dzVjh4RS81THhkUDZvTk0reE16ZTVPQWEvWGZRblJN?=
 =?utf-8?B?NGwzWlBSSXlEbHRNeTJUMkV5YVdKZ2cvTWxiTlhvRGRTZkIvdmhxWnVNL0FK?=
 =?utf-8?B?MWwreXp5UTdlWCtLUElzQThERENLbUo1LzdHOUdiNjU2T2RUbUFJbE5yaGk1?=
 =?utf-8?B?RjY3VUhZRGhZK3BtQVE1Wm5sMHcwOXlYeDFIZ0J1bjcrVHdteWY5blJkcGxX?=
 =?utf-8?B?eXVBa1hKTVJLQmJSMkxDV09GNi92M0wvakh4NFlXbitlM1BEVllSdlRpdkxk?=
 =?utf-8?B?WDdRZUhBSDBaTDBEYWxRSXRndjNmVUR6TWdmYXY5RW5rVUFvaHNVN1N0UkNV?=
 =?utf-8?B?czZtY2pVMm9GSVRYN1kxazdsc0FJN1hOc0cxUCsxTmg1N1gzdVpCUTJVUjFV?=
 =?utf-8?B?cjhxTVY4c1Fkdlc4VUpVbENHaDJ6aDB2bXRjOTQ1dGdnZHhWMG0zZlhhdDEw?=
 =?utf-8?B?MFVTSnI3ck5RUjJ5L3lvb0JQS2M5bHJ6c2l3S2ptc0VOOGZiVmNaaGdGZGhD?=
 =?utf-8?B?MDMwM2FWbGM0Um9pZDRWcFJScCtwNlhIenR6VmNUU3F0WkIzT0dEMjFqVFBh?=
 =?utf-8?B?OUV6RXloUFM0Y1NydmdxdGRaYUZRM3VjcHZGOWpmRFBpMTVhbzZSSXBXRDJO?=
 =?utf-8?B?dnRVNERwT0k0SDNnRzZGYVRLNDlBblltcGI0TFpxNCtWVEJqdFplMDBFVk10?=
 =?utf-8?B?UUZEODM2KzdDOVhCeit2QnZCcjBta1p3d2pZSkYwWlVzck40dlNFNStNSUNu?=
 =?utf-8?B?dU8zeGpZR3I0am5mV1JybGU4NXVzUXdXWEZCWUQ0Wms1alNYTGJvOTk2S2Fs?=
 =?utf-8?B?bkNaWVY5R0h4aDEzbHNHeTZvY1JmOFhNWVkyS0RhZmpURjVHMnZCK3R2elRj?=
 =?utf-8?B?VTFTaWlVQTVCalBsaFN3N1JVWXNQQjc1bm02OXhSaVcwcUd0bzljY2Jpcjc4?=
 =?utf-8?B?aDVvTFdmSC8vMzUxTGJXTnAvVjZ4enhJM3J4Tmwvc1R2NHVmTnRWTGVwNldL?=
 =?utf-8?B?amJtQ1V0dVcvc2J0UUliUFNucWoxSjA4SDBhRkNhbUlIbUREbkpoLzRXTDEv?=
 =?utf-8?B?bzc3MUtwbnd3UDJlMkNkNFhxYS9yR1hGcWVSa1NxenM4UXhPTDZiVUhkbGh5?=
 =?utf-8?B?cUxBS09oZWZRbkUvcUpKL2UvdTdneDI3a2N2ZFliSW8zaldUbzVNclJkUzFE?=
 =?utf-8?B?U1cxeno3d1lRSzlmckJQckhSdmVtQnRkMlpUZ2ZyaTdJUWIvbTZSdnJIaVRT?=
 =?utf-8?B?T3l1eXhFLzdQSm1mRzhZVy8yQzFvZXdRSHVCYU1hUGlmWDU3dVg1U1UxMlJ2?=
 =?utf-8?Q?snDcMaX8J5lYY6y51CrV4IxBqRebsHVTEHhJx2Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXM3YThFWUc3a0l5ZUQ4MGhNRXowdnBNUjN6WXZHZHhSaTRSVXh2eVVadjRv?=
 =?utf-8?B?eHJkUVJPVmVKT2kwN0lVUXFKVkRyRVVZVmIrNkJ4TDhsa2NzL2E1U2Vvblph?=
 =?utf-8?B?aTNPNUw0TkkzekduTkkrZ29naWs5MDBsck4zQ2J4L3MxTVRrVjBDZnBBVDZn?=
 =?utf-8?B?V203TFNxalFWSzZaUHpGY3daaHMzT2FreklYTXU5UXY0WEp6UWM0YkJlc3p0?=
 =?utf-8?B?WmQrMTBQMzh5OHpub3FhY0pOMGttdXJ6dVVIQnpiUVJJM2ppWE5ZYkZOZTNN?=
 =?utf-8?B?WVR5di9kU0Fuam5ZN3NuVlkzZ0hIYjE3U3JEVUpONnZmeHNMeXRDT3dMd2kr?=
 =?utf-8?B?OTRDQTdQdW4xMEJ0aytxN0w1WHBZRmdRWHMrbVpjOXd3alNsbFlpN21JWGd3?=
 =?utf-8?B?YU5lSkpDN0tBVUNUVjVNclRKYnA1YkZMYkUyQndTK09WVUk1ZkZxWDNFK25P?=
 =?utf-8?B?UTlINWQ2Sjkyd25vNkJnSDcwdDFoYWxLNU1jbXdtS3BEY1hUK1lkU3kwdG54?=
 =?utf-8?B?ZEJzYzdtRzlDK29jV2pXMHBOMTJWNnRjdG5jTXp0MzVFV3ROdlo1SGxvd0Qr?=
 =?utf-8?B?NkV4TUpaOUpYRUxEL0VVcFZuTElEYTgwdEZvOGsxQmxYamo5bjFMdGJDZXY3?=
 =?utf-8?B?cEtUY2xvOWpmQkNvRW9DYWpWdUx0WXlUWmUvQnZnMDFhWVlYVEVIN1YyYnJs?=
 =?utf-8?B?REdEYzVZTGgrL3liSUoyQjdnUHlVQnlYSGUzajA3N1k2Zjl3K2hWTGpNdmZ3?=
 =?utf-8?B?WkFralVKZGt5cThHMVdNOWZpNmlKTlpGWTNnckY3OHBUSkt1SlZnZWw5Rm1x?=
 =?utf-8?B?OXVuTURKZ1QxSnpBYjFZODRJNWU2QTdKQVc5ZmZEMG93ajY1L0hONlNnSGRB?=
 =?utf-8?B?TFN0cmZ4S2JxVjRTR0ZiVVZFVndaMWFOZGYrd2hjeXQ2VGtScXVGd3NRNnJm?=
 =?utf-8?B?ZUMzRTZ3TWdKUitRNVprdlg4SXFScXZzREFCeVVoUFQvazJrdXBldFpUNkpy?=
 =?utf-8?B?VEtLdXRaSnlVSlFDczBQVnYwK29uRTB1dW4zVEpwTHRmVUJIK0l2TldOcUQ0?=
 =?utf-8?B?WUxNUzJmM2tRR0w4blJBZi81ZzFMNVhqSmNpeHo2V1lEbXU1K0lEMXV5ckkr?=
 =?utf-8?B?MnBMWHVZamxNK3V5RnpkdXdMeS92R3JyK0s3cDdUaWJoUnArdlRlcjZscGZp?=
 =?utf-8?B?M0w0czEzQ3Riblh2eFhPN3Q4dzB5eW1rTmdnUFd3d0FlYUxORFlQdEJhRVZ0?=
 =?utf-8?B?YkhzQi9pQW96RVFkSXFhMlZ5Mk9pRUQvTlVNeDVHMkIxN3BQUWRNU2V4dUZO?=
 =?utf-8?B?Ry80K3BqTkVXRlhMdmFzNDlHUWRheWV4SjlBRlR6TEpsS2RLS1hVWVhpN29V?=
 =?utf-8?B?UXVBOUhYYzhObkZYWk04OVp5L0tCazJtQjFFRWdmclAxYkNOMlZiRlAzTnBT?=
 =?utf-8?B?Z0wvcHVoNWJqenIyWllBTGZYaXpVd1Z2OFR0Mkh4U1UxTDhRU3ZnRUxGNUI3?=
 =?utf-8?B?bDRtY3lOUmRjc2tXeW8rUXB3aXRmcDlvaUNsb0JubzhjaGJ4Rmc2YUNPMHVq?=
 =?utf-8?B?TmszNXdPRkxUczFqMGdoazk4K0VDU3hZK0o2OEUxbzBKOE91K05YajFtNUdO?=
 =?utf-8?B?NWJaZVZrWnFCYzkwbkFFZXRhVkRNRThaWFEzK1F5TXl3cE9XVTV3OWRCTk5w?=
 =?utf-8?B?UHFaVElTTHR1RDh1dnpGSGFmZEdDdmZIZXdjZWxXUFZaVjZDbXVmQmh4UGFH?=
 =?utf-8?B?NG5GSmh2YzRXa3kyS1hoZDJmQWY3OGlMdndlUUFTSDFkTksyc2ppbUtscFlO?=
 =?utf-8?B?VThaeEF0dmk5QkpDRnpkOTl0OGNSVW92MUhmcVBoaDNFVU5HdTkvS2tnK0Nl?=
 =?utf-8?B?VVBKTEg5Nk5ablhyQW9lYUlCK1lQWVFTb2xWZk9xaC9Rb09ISXAvbC9mdTh0?=
 =?utf-8?B?TGhKNmVsbHZGWUYyMExTOVRpRkxMRHMwYVJUTnZ6RE1PV1pUV1BONVYvVDlw?=
 =?utf-8?B?ZUUyOWtzdEVnd1M5NmlNZG9haE4vUVRueFllWDRaSDNtNkM4SWw4dEhaelcx?=
 =?utf-8?B?NDM4VXl5S0dDWWtWN1pzODgzZElaZkpHNURZSU5EUkpVSWFucU1BTzFWY25S?=
 =?utf-8?Q?xF5Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8aff9d-8b6d-4d57-6e5f-08dcf1a65f95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:00:05.3435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCjTHyD+bc8QaM8wWH21cCKH7gPSm8IlmNLx9j3XWLTZQk9kKpg95chrukHiykt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

--------------TgZdkK0Go0wQiUD8L09HVdKj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.10.24 um 07:56 schrieb Chong Li:
> change the gpu tlb flush mode to sync mode to
> solve the issue in the rocm stress test.

And again complete NAK to this.

I've already proven together with Andjelkovic that the problem is that 
the rocm stress test is broken.

The test tries to access memory before it is probably mapped and that is 
provable by looking into the tracelogs.

Regards,
Christian.

>
> Signed-off-by: Chong Li<chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 51cddfa3f1e8..4d9ff7b31618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -98,7 +98,6 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   	f->adev = adev;
>   	f->dependency = *fence;
>   	f->pasid = vm->pasid;
> -	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>   	spin_lock_init(&f->lock);
>   
>   	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> @@ -106,7 +105,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   
>   	/* TODO: We probably need a separate wq here */
>   	dma_fence_get(&f->base);
> -	schedule_work(&f->work);
>   
>   	*fence = &f->base;
> +
> +	amdgpu_tlb_fence_work(&f->work);
>   }

--------------TgZdkK0Go0wQiUD8L09HVdKj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 21.10.24 um 07:56 schrieb Chong Li:<br>
    <blockquote type="cite" cite="mid:20241021055644.158966-1-chongli2@amd.com">
      <pre class="moz-quote-pre" wrap="">change the gpu tlb flush mode to sync mode to
solve the issue in the rocm stress test.</pre>
    </blockquote>
    <br>
    And again complete NAK to this.<br>
    <br>
    I've already proven together with <span data-teams="true"><span class="ui-provider dy lx ly lz ma mb mc md me mf mg mh mi mj mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nb nc nd ne" dir="ltr">Andjelkovic that the problem is that the rocm stress
        test is broken.<br>
        <br>
        The test tries to access memory before it is probably mapped and
        that is provable by looking into the tracelogs.<br>
        <br>
        Regards,<br>
        Christian. <br>
      </span></span><br>
    <blockquote type="cite" cite="mid:20241021055644.158966-1-chongli2@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Chong Li <a class="moz-txt-link-rfc2396E" href="mailto:chongli2@amd.com">&lt;chongli2@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 51cddfa3f1e8..4d9ff7b31618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -98,7 +98,6 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	f-&gt;adev = adev;
 	f-&gt;dependency = *fence;
 	f-&gt;pasid = vm-&gt;pasid;
-	INIT_WORK(&amp;f-&gt;work, amdgpu_tlb_fence_work);
 	spin_lock_init(&amp;f-&gt;lock);
 
 	dma_fence_init(&amp;f-&gt;base, &amp;amdgpu_tlb_fence_ops, &amp;f-&gt;lock,
@@ -106,7 +105,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&amp;f-&gt;base);
-	schedule_work(&amp;f-&gt;work);
 
 	*fence = &amp;f-&gt;base;
+
+	amdgpu_tlb_fence_work(&amp;f-&gt;work);
 }
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------TgZdkK0Go0wQiUD8L09HVdKj--
