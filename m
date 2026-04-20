Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8521F5A8BC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 21:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F07989A60;
	Mon, 20 Apr 2026 21:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNho3n+Q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7926889A16
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 21:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO73RHdcyy+GdJ5a+C63/dD4fzzV4HKaworTD3mL0IlmJsTFX87663se4LN/bBmkCqsf3lPUsKPVhOURMkAatD40HFSzoWSQaWz2kKZnepzS8TiexNxCWh9LA52mmvPwtYWKvsq+Id4jTm/s0OUoR6zKgZQvwbW/ZPa/sErN5q8tC/WVJv47GdeCqScvvOT2cfZVyGG0WmMgluVNbBt/h+mQoGiuxlkT36EsNSr7NxHBTy/Be6Kf+vUXKUX5JTbldQJAcWtJ15JVZnFmenpuq0XBSyDUCQklyyZMsopTx36O70mpALtAglkW2iGThtrk5Phsn9pixMWKBLEBccsQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD6YfmRqKdR6mqdPf5Rbewu7qs7nTNOBjL0G8YufoCE=;
 b=KFKKCpc26Bu/OkkHSCSPs9Usb1SRbjz5UtIQLyc4miL1WvAnxGphGP2HGoxfAx6QajAGeN2agR7DlfSgzMYFApA2zA6LclxIYSG6JAV4u1hp+MBmlCtPNrfIysrv8CqLM3FZwnOMXmaIgEGT2mSUmyEib0svSgW6LeqXhbpTBAzfyU8Csle9Vl3HhHltWsEBCt4ztP4OO+RFgECbIfdkQyBM02z/34u276T1mWB3IZqmotq8Y6UOQat46EWMeiZM9SGrxx25YdI363hc8iDxzFRopBhRK2Q5EBBcK/557YqbD0jRn1bLskdMRfdQ+2Kij2phqmrnZaZuV6eH28lWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD6YfmRqKdR6mqdPf5Rbewu7qs7nTNOBjL0G8YufoCE=;
 b=nNho3n+QouMusMsaWe1YsJD7+4SznYec6q1bg5nfQpTo8lwEQMiOo4bnNouD85PFQ4UxltPHzoce0snUl5h7H7QcCw8tNYHmD3+1YT2O0M6scrTkK4VXmiBIzh9wqj/NrzXMkucA7n51Z83CEu7TvrL4V2zqor4oy+FoPkjgi/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 21:25:47 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 21:25:47 +0000
Message-ID: <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Date: Mon, 20 Apr 2026 16:25:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Kent Russell <kent.russell@amd.com>, Xiaogang.chen@amd.com
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::27) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5bbaf9-aa31-41a0-5b2b-08de9f236334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: puK1gDlDiW1TZ8A9oRQstYGMkz+TJ75cFpg+Pi3cNJqmuwiZWYH7b3zmcdRM/mwtgJq7jx9ws4lu/wuITkF6aYPtulrEFQLrS2UlDNd/JHC5OMlp6UYjKPnzoVS68HqzTnTZx7vS7QCTTunf/KLhRL6fM8iY/b+HGA7aaaCNTK1kxpT3t1jCtjC8EtiORazFs8coQAZ3003GIt23UzG4XFvj5fO7darBhf3ESEBk7Z0rT+ObfqvhU1PbmQ28tS3MEar7RT9Qdomx6N5ULFwaArU7hJ7ssKaT9ocfScZErubq8w5nBp33NedE07F0oPjupUAsUoLI9AwyNr5X2qkWMmwXuoqlQ51YJ2A6OtrBjZUU4SlLq7VbIDV4pwaiYDxaIMLiBNssyWRizHu6GQ+7qbvfJXW7BC1f1i2J6J9N4dZIExDxTKC+ejhT28bNjTwIAwBiTlo3FWLOgmAONSXjQRa4g3scHOZI7UOKlvPA0vGPme673NjRdOE3HX0MhOWSyyhvAk6q4Lsx3UGf+uy4bfUW1o6jkvhOW/d6Rxj87lYvn4obfGIIyzBC4qaE/FI1TnSV71vzAmTbdNoLOQeu00KgHyfsY+lfjvSNhRGnxyrr/hD1qIwB/xKrtUav4mosrOfRYTUztUmn+qRnWThADtD3+aBG/TJFW0uCLpWaPPO59+JRMSGpI9S9sQARjVPaxEkXWvJ0w0pa7BwIq0rhNn32tZruOZnxv4ko9pL5JWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZBMmtmSWRDcmRIcVI2eUMyMUoxYUhQNVp6Qm12dlhrS3RKeEN2ckxha01i?=
 =?utf-8?B?eWJvdVd4L2Y0Z2JRTFRHRG9BWTgxbWVjSUhCUktSWkl0eWJWZUdQbVc0czRN?=
 =?utf-8?B?eVBUWmlZdEpWVlF3OWcwYzJMeGloUnV1Y1BiR00zNmxudVlGZFZ4bXhxaXIv?=
 =?utf-8?B?anpHVjFBWmpSRGpQL1hYMjdiaWRxYWs0QTJDSE1jRHk4bVdya1RlZCt2cVF5?=
 =?utf-8?B?Z3hCU2E0MEdTNWJFejFzRnV0NklCWk1NZndJVm5WdW1PcnU1QkFFS0VubDdq?=
 =?utf-8?B?TGp1S3dLT3cwK2w3ek5TcHpBd285U1R4SEdJb2pKZm1zSVhGMnFEaDg1Q1F5?=
 =?utf-8?B?bEc4SlBkOGpmYzFnSUVkUVIyVlJMZlRZMkw5Tjk0d201SU9SUmVZM0Z4OTlu?=
 =?utf-8?B?dXM2MmdmUndLVmh6UklQSHE0M1hvRlFkRkczSlNkdG10M1lYSE5wRHg0d0pO?=
 =?utf-8?B?QzBPaGxFeFJmWWgrRlBZbmdYdnpuL0xJK0pNOG00UFd1OGVkV0x4cUtGVVFB?=
 =?utf-8?B?cjlRU1NSbWJPUUErbC96SWVvWGdTWERYdEM5WWVIVkcwTjlHNzVMK1JLTWxR?=
 =?utf-8?B?RDkyS3hLTG1jS2FFbjR4VWZVTE5FbmZrUXF5VFhWdVUrdFc1bDd0N0wwbEhr?=
 =?utf-8?B?ZHFkSmlNMUVQRU9YajRTNlVmQjNxckt3cW84dC9uYk8vWXNJN1V5L1ZpOXUv?=
 =?utf-8?B?bkxSK2RWS3NhaEpWZkZ6V1cyTG4wU2VZMXBEWVdEeUdFcnVRcWFoZ04wa2Jh?=
 =?utf-8?B?NFNYSzI2Y0hpY0xiNm80b1MxTnBycDYwL1ZJSTlxejV3dWhmcGlKdERnUDhS?=
 =?utf-8?B?S3ZNREpWRStUbkJudjFMckhaSkFmNkFhN255dnhwYzc0MDR3QzNnNDI4a29K?=
 =?utf-8?B?dW4xVnp6Q3NGRVhMazlhUEoxM1pIVTJPT3dOdUszaW9BZTl3YWs0Sk84dGpp?=
 =?utf-8?B?UDF1YXhoaHVncmVFWGduUzg0VUdJOFFYUVI0Qk9QbGIwaTAxY1VVTGhCdlI4?=
 =?utf-8?B?VjhZYVZaVlcweW9MeHdIQ1Uxb1ZjQ0NwVGFPdU51NFFZRkxLRzBqS09VT29k?=
 =?utf-8?B?U1NoYWN2cG9RSGlzdFYvUXpGNEJmNEoyd1VHTytaM0tvSk9OL1llTHkxblNC?=
 =?utf-8?B?cmIvSzEvcTVTYWdqd1BqS1kvTzhOQU1SL1dLZ1lodXZNc0NaU0R0R2prcW9Z?=
 =?utf-8?B?STVyT3EyakRkM0g1SmUrUTc5enBxSVFmanpGR0R1d2VwUGxRcGNrV0R3c3VL?=
 =?utf-8?B?YlNteTFscjlBeDdMb2NuODUyenZIMi8xbysxbG9jSlBsZEZjNXU5OFEwTkRO?=
 =?utf-8?B?MlpLVjR6a1NrNmdla2xubnBvamxYTUFpdHgzK1A3V1QreEZIQWlLdkRobkFC?=
 =?utf-8?B?OXZBeWFlSDNBNEFpVGUrZ0N3Z1pYOVlzd0E1WVhpcnZFYjRlMlNETWttMnhD?=
 =?utf-8?B?R3V6MjhEZTJ2Y1NVL08xQXdQbU9wRE9jNmtKMmloS2VNZDV5VzQ0cVZLZWlk?=
 =?utf-8?B?d0NiY3g0a3l6ZWw3M3pJRmFhcVE2OWxyWXNZUkI2dGxBN3Z4NkQ3SjgxQ2s1?=
 =?utf-8?B?ZTlZc3h3TlVkQktYS0UwamZnLzZnVlRxZDZvWkZWWkpjRVllSXU0dWp0Vnhr?=
 =?utf-8?B?SUpDeVdYc000N25pTVVXSFk1cVBjckNiS245SEd5TFBJNnBFek56eGlxZm9s?=
 =?utf-8?B?UExhcFRHYjM5VWNISzhwMW5wc2Nta2VBYjBlVnhWellyRkRocFR0S3VZRDZs?=
 =?utf-8?B?dVhVSHczM2hsLzRlSmxuUjdLdy9xL3JCTmdwOWhOUG5yZElBV2RkVkdBNTVs?=
 =?utf-8?B?Y3ptT1lpUGxoeXdCVFpDOVEzL3F6VGkzeGlCZjNqSGtaeTliMmVSZUhYY0Fw?=
 =?utf-8?B?SU9OVys1NXFHNDBuVEdXN3h6N0FYci9YNlh0ZTU2NlF6d3pNOG93NzQ0WGxG?=
 =?utf-8?B?UStJd0FUYk9XdWlod1VLWDBEQk5CT1NmQjJIR0g3L3AveWgrZFNPTitFQ0RZ?=
 =?utf-8?B?M1RVSDNoRGdGSWhwMGpnZmNzVytTOER2bW5QNGMrSFdsY0pLWUUwWVczSklj?=
 =?utf-8?B?L3VDbFFzZjZjeG96aTczTFFtaGdBN0FoT0N6OTltZVB0bDRLY2x3WlMvYUV5?=
 =?utf-8?B?NEUwUTg0UW14SVVHdURSZXErdWdDbzNzTEFGZEFTcGd4RGp5YkJEcnRPOTBR?=
 =?utf-8?B?KzhTbnlKNVR4UThYb2N4ZHhycVJnOU5JeHh3UW9IQVpsWWdUSExEOE95SFNN?=
 =?utf-8?B?RW1CME91Njk2bGRaUVg2UXU2YW9tYmlHbmdocVpONTlMZ3gwdUZHNkdTWXpD?=
 =?utf-8?Q?TbpR4fsRIKj+W7Nvq5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5bbaf9-aa31-41a0-5b2b-08de9f236334
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 21:25:47.1971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlZCwcysII7PemFPu8ftaMQnB4zu1Ut3AJhpadPQrHqudvd6F6UfIyzBuuiqGoBw8Qd2xHFUod6fi6v0iZeQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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



On 3/7/26 06:49, Mario Limonciello wrote:
> 
> 
> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>> When a surprise unplug occurs while a process has active KFD queues,
>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>> properly clean them up. This leads to a WARN_ON in uninitialize()
>> complaining about active_queue_count or processes_count being non-zero.
>>
>> The issue is that during surprise unplug:
>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>     dqm->processes_count > 0)
>>
>> The warning triggers because the queues were never destroyed - userspace
>> had no opportunity to clean them up before the device disappeared.
>>
>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>> calling process_termination for each affected process before
>> uninitializing the DQM. This mirrors what happens during normal process
>> shutdown (kfd_process_notifier_release_internal), ensuring queues are
>> properly cleaned up even during surprise removal.
>>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Kent Russell <kent.russell@amd.com>
>> Cc: Xiaogang.chen@amd.com
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Ping?
Ping?
> 
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 ++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/ 
>> drm/amd/amdkfd/kfd_device.c
>> index e9cfb80bd436..7727b66e6afb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>> *kfd, unsigned int num_nodes)
>>       flush_workqueue(kfd->ih_wq);
>>       destroy_workqueue(kfd->ih_wq);
>> +    /*
>> +     * For surprise unplugs with running processes, we need to clean up
>> +     * queues before uninitializing the DQM to avoid WARN in 
>> uninitialize.
>> +     * This handles the case where userspace can't destroy queues 
>> normally.
>> +     */
>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>> +        struct kfd_process *p;
>> +        unsigned int temp;
>> +        int idx;
>> +
>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>> +        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>> +            int j;
>> +
>> +            for (j = 0; j < p->n_pdds; j++) {
>> +                struct kfd_process_device *pdd = p->pdds[j];
>> +
>> +                if (pdd->dev->kfd != kfd)
>> +                    continue;
>> +
>> +                dev_info(kfd_device,
>> +                     "Terminating queues for process %d on unplugged 
>> device\n",
>> +                     p->lead_thread->pid);
>> +
>> +                pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>> +                                       &pdd->qpd);
>> +                pdd->already_dequeued = true;
>> +            }
>> +        }
>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>> +    }
>> +
>>       for (i = 0; i < num_nodes; i++) {
>>           knode = kfd->nodes[i];
>>           device_queue_manager_uninit(knode->dqm);
> 
> 

