Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545B606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qUVWJKIS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D4310E460;
	Tue, 27 Oct 2026 18:53:31 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1B510E45B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 18:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmzAgswFsfNiy40YiFGdfnYIcZsOi9RvTCp8TOfs0GMMQ1rXCsBzIXN30JVY1rzl+dE3ctKtYep7wNEbHb5Q8Cd/s5u3UjUisaGXDnWOB8XQ2/lHvY9q7AvLMCxBE8f06ZNn47KTlMlVeWyEyHHOZAvUUrrD1y+d0kalxg7G7xhwEL4co0IinX/lOdmz5sxPpWPbZ1Rk0vrmMFWi6d/PxnwG2LFH9K7SZgkJEmngu5UMVRL4dFnho6GY4YxLPXlokFGQwNcMIvSO99ajBIC8htpplkdbiAYsMxKi9LFArSgzDjVZvj8SMsW8a6zA3rm34C3Qh5dxZtqLj8VGpQrtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNfgVyFXeG9LcjaYoKKmJdop2PWqbex9tCDHuhPWxLw=;
 b=uBPZDQQdqEqGmFSAAR5JOoFB6PNutVfS0BBv5JFpNorDCX4F9/AHwBJiIYGYbKDMcOACsYSXB4wQFrRvlKBhQjfdvETGokNQWs9+vhLcshW1AIrq05oTxFi7FBf7A1UiBYgAVIA0n+KKskHqAgACYYh/bnSpR+WGcUnr15Nj6WLZofQgqzmYvWKMBWzutoS/Ibcn9XxNmEXK36eIUW5yl/2i/zq8CQh/jq2nCOmXXq7Xdg4WFxuED9yJSbZIc2wxI4O85gcNJUEcNnmZ4bgr518gceWknwSv/ocsqdWCz95436tFAlTscvt7c/U3nHEpJ6u9aQ1j2yQVZtTGjjJnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNfgVyFXeG9LcjaYoKKmJdop2PWqbex9tCDHuhPWxLw=;
 b=qUVWJKIS328byM3K/98pTWVqLehdmhxJeryHOE/OcnZB+xMnYwpncDMi24aatVBumyxN9x6KzwitQJRqMMiHY2zxXhaLicNQeIUGCTTjwp1BAmkAMA8nGnF1kEy5P1NwOFW705gFLx37vhMlE9wStdImNJJDsXaq6MScGsAps7o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SJ2PR12MB8689.namprd12.prod.outlook.com
 (2603:10b6:a03:53d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:53:17 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:53:17 +0000
Message-ID: <f6829b65-0961-47a6-8513-21b38b323ebb@amd.com>
Date: Tue, 27 Oct 2026 14:53:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-2-mukul.joshi@amd.com>
 <d5006221-41b2-46c3-b5be-6a5f9bec0034@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <d5006221-41b2-46c3-b5be-6a5f9bec0034@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: aad9886a-f70e-4e67-9386-08df345b8fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|6133799003|261026121527099003|3023799007|261021123027099003|4143699003|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: ssZ6JBCZm0+v5dIBJiRrkeokg6V1nJozvmE13dAqYa9vd2ffNhosE+18TTd6Up1yZ8tux7G7mTeUe6GgWWj6N+W+uSoF+pfNPjC1MRSNp+bkzqKpDHXjSk4iKXlo5cAULXdOPAJwIaoJM6Q6JIKQ9fRi2m6Snd2LNZAWW77/9wYhRqQWv2Xf9bFab3c5B72PQKTPi+/87BUDLt0iUfaA6aYEw3siLfPT3cABhc9Q4ib7VS1/Lrcdx+XAlO3Td8FDPo3QsqQJt7kX5N8z17GVl4Ouv5psjg+zzkMOkfPskd0JHar0Jx9+Lyb4N7fLI30E16dlN8+a4TBqOVlnaqme0N2OVmq6NeyGdkGdxwPREpUrK8ZxhgTflnISkZjkv9JzMAMYHuSO0vIlVSo7nNdMmkpETdMMzdovmJuZD/MlFPiepTpVXCfXXWMPXOaieIAjiYtw7hjW/8H7jtxnm+7LiY6apzGyocx/iUfgw6Kfac4RSxPiZdoc96ICyOM06fsmPgMd8Lol1u7i8oDPHhA4jzOFRLl1OwJDaUsJV/ruoH9/WQqC8osTJA+2C3UbeG6KNDengLV1uTJAKwKnkLViOOwz3BGADbTyTBUhh9Fn3C6686KhSFbdcezk7Q4SPHKydMTo/I7aUcNXwKVRKa6RzUZI4KlyQrLvhOg2+xXrUx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261026121527099003)(3023799007)(261021123027099003)(4143699003)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czd0QkwzMFFSeXlUR1NKRUhmMzRodzFSd0Z1REZPL21yakw5NmQ5dlRncEpI?=
 =?utf-8?B?RTllWnhwMzJNZGM0TW1YbjNMNUZYcXc0SmdXQUhJNytyZlFLMEZ5eXVPbHNm?=
 =?utf-8?B?M3ZnZnloSUgwbjZvUkZGejZmbDhkYlJhS2xrK09vUFRrZWhOd0wwQVJqR3dz?=
 =?utf-8?B?K0xROGRWMHBWcHdXeDJtWEJMaWR1WjcyTGFuVjdvWEFRT3dpWU51L3JGeHFP?=
 =?utf-8?B?Ni9RRUt1ZloyVG9oc0dZemxSREtRUzBGNlBobDNwZHkrOWF4ejY3UitkVHZx?=
 =?utf-8?B?Z0FQbmMwVjA1VTEvTGZWOVNzWEMrdWxwY2FWYStmajR5aENCMnEvMkcyMUk3?=
 =?utf-8?B?QzJLYitqemRTUnp2a25DYklLd3U1ZURRRjZuOFlEcmQvRnNVYVBhdDdHUysy?=
 =?utf-8?B?c0dTOWFaOXpsRUpuakRMaE5QZStNSmRocndKV0RXamJWRnJGc29WcmtBQXdo?=
 =?utf-8?B?T1pKbG9YenZXREVwZjdmQnZTSTRiMGtGdDh1NDNyaVU4NFZLYWZhUkR0dytK?=
 =?utf-8?B?Z1JPMVpWWXNlWVlUa1oxVmEzc085bDhWRzUrSlJCaWErYVByQmNZN0lGVWpD?=
 =?utf-8?B?aU5vdkN6aFRkV0NxNXUwWXc1bG43Ny8zVW9nQy9GQVIySWVrNmRSdjBaQkt5?=
 =?utf-8?B?amptTGhxdmxTdGVXa2tmemNSRVF5NG1lYkd2NUVwR1dtSTRSQkMydHM0ZDFG?=
 =?utf-8?B?c25KWWJROEMzdlhSQldXVmdtcDNPaElxM1Q2bUVTakV1VHVRK29qR1ZHK3BY?=
 =?utf-8?B?SWNnQ1FrYndoUTdtVzRUYld0UFIrZjY2WlBDc1NxeUk5bGo4SmMxN3hpVWxs?=
 =?utf-8?B?eVNTSWpjRTQ5cHdPVzVPVkEwNFRSa0ZnRlptaG9QQktSU0c2Q05TU1hVbXU4?=
 =?utf-8?B?L2VEUmlkbnBmVTZ0VjdvaW53SHI2L0d1Zy93NTJyNjgwR0YvZnlzVWtHY3h1?=
 =?utf-8?B?anZremZMWCtNZTVydU1yZUxwMkxqb0VHNkFwYTZmelhUYjEwS3lsVk1WRWlq?=
 =?utf-8?B?dFNrVVhKaS9MdjNsWFNKVXhNUGRwSjZHTDk0OE9jRkxXeHBuSmJQUitvM0Iw?=
 =?utf-8?B?NU5QZml6dUpydndWWWNSZStzRkc1VDZ6R0poTTZ0enFkS1lGenpUKzVvYjNK?=
 =?utf-8?B?MFNDUXQvaVNKS05qS2FUL3Rlekwya3Arc3JyY0lMOVdxMFVLMjAzRFMvYUdQ?=
 =?utf-8?B?QmF3QVpRK2JjVnlKeENXL2tDNHBLOWM1REMwWkEwdDg0V1ZlTHVVbzFPNzFS?=
 =?utf-8?B?Tm9hUTFuU1BzQ2xTMy9VTUlCL083TVo3b0MwNXh0NitGZ24wT3RtWVk0Vzdz?=
 =?utf-8?B?UVFzc3J6akJWRjhmOTZKMzFhck9uNVZrck9hUGVhaDg5aDBUYkpmbmlOL3NK?=
 =?utf-8?B?K3MvQTk5YllvWmRKQndoWWM2aG1FMzh6bS9neFdoaUhkWjczdnJHODM1Lzdx?=
 =?utf-8?B?eWd6L1RnRFZ6c1hVNmEzVVNvVEdMdGc5Qnl2MlltVEJqZGNNMElPVGRBV3dl?=
 =?utf-8?B?ZDZtL3FZSTdhUmpEL2pSOVg5elZMK0hPWk5aTU1xVVg1MXJBbmxDYnRGQkR0?=
 =?utf-8?B?RlVkTm01cDVOV1NtZ1B1Wkk2Nm5HTUQ5eW83bFQweVY4YUo1cCtzN1FINnVo?=
 =?utf-8?B?NnAxMWhjQnZ6cDZjczBFMjcvci83dmlhQUJma01DY21EeDdKNjZFK2Z1cjAz?=
 =?utf-8?B?K1JsODVNRnBDWlpXT0xVT01Da2VXR1dZc3lUcVJ0MFpiRzRabW4yUVZHR1RF?=
 =?utf-8?B?eFB0YXVsNUlSQXRGMmJzaUZGc2lxVVhLVWk5S2t3Y3JtLzNxWk4raGpEM2pm?=
 =?utf-8?B?WGR2bjdZdFpCY0ZKZk8wZmFrQkkwSWY2MHMwRHN2ZUlXOTRnZUN4ejM4dk9U?=
 =?utf-8?B?RUpqcWVWTllwWXFQV092UGt0dEJKY2FWVlhCY3F1dkNJU1BQdk9nczNJdXV0?=
 =?utf-8?B?SUxyQlhRN3Yzd2N3d0lDbDNmbXl1Qkt2RUFERkNrQWh3VFUvZytSRFpsY3Qx?=
 =?utf-8?B?R29yUFBPNmhJcWV3L2hWZGQzZjRqT2JKYWI2TVZhN2VDMm1UY1lkd3dtUzZF?=
 =?utf-8?B?ZWpxQjFwNDhZYUZuY3VVSU1XRXdUc0w1bTFRODNHTHJpL3IzVGsydEkrOGhz?=
 =?utf-8?B?YTNRTStrcjdEbThiTWRzVE5LQWV5T0paVkY2cTc0M3lrSTJXbklFYkdudkFQ?=
 =?utf-8?B?eCsrUk5RZ2N6Y0lEUGJ1TU81NjNaU1VROXM1WnpCNWk5MTYxMzIrc0t3ZU9r?=
 =?utf-8?B?TVRuS0VhZmQxUDdNQXVMcGltcXNhd0VLTkNnYU8yOGFRT3NVT2l2RXdjMHBM?=
 =?utf-8?B?S3FZZksrSHFBS2dxUWlmTE5ZdzV2a3BlaU96ZDh0aURRVGpMVitOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad9886a-f70e-4e67-9386-08df345b8fd8
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:53:17.0689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyipvhsuS5r61q/ab3VnjDALHIdeyrb2thYu6tJZsfNbs1fiADfUsNAPLgR+tpbUcyG9tbPhBlKeS1S/j7SBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/27/2026 2:21 AM, Lazar, Lijo wrote:
>
>
> On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
>> Add the infrastructure for UALink loopback mode, where a single GPU
>> plays both the exporter and the importer role under two fixed
>> accelerator IDs:
>>
>> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>>    with the fixed exporter and importer accel IDs.
>>
>> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>>    ualink_imp_accel_id(), which return the exporter and importer accel
>>    ID in loopback mode.
>>
>> - Make find_peer_adev() resolve both loopback accel IDs to the calling
>>    device.
>>
>> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>>    workqueue used to emulate exporter->importer messages, and destroy
>>    it in amdgpu_ualink_object_fini().
>>
>> Loopback is not enabled yet, and outside loopback both helpers return
>> ppod.accel_id, so there is no functional change.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 117 +++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
>>   2 files changed, 124 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 2ae14e83f6b4..288c07274254 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -88,8 +88,34 @@ static int amdgpu_ualink_drm_client_create(struct
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +/*
>> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
>> + *
>> + * Called once loopback mode has been detected. Allocates the ordered
>> + * workqueue used to emulate exporter->importer interrupts in SW.
>> + */
>> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>> +{
>> +    adev->ualink.loopback.wq =
>> +        alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>> +    if (!adev->ualink.loopback.wq)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>>   {
>> +    /* Tear down the loopback self-interrupt workqueue allocated in
>> +     * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
>> +     * pending self-interrupt work first.
>> +     */
>> +    if (adev->ualink.loopback.wq) {
>> +        destroy_workqueue(adev->ualink.loopback.wq);
>> +        adev->ualink.loopback.wq = NULL;
>> +        adev->ualink.loopback.enabled = false;
>> +    }
>> +
>>       if (!adev->ualink.info)
>>           return;
>>   @@ -479,6 +505,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block
>> *ip_block)
>>       psp_ual_query_station_config(&adev->psp, adev->ualink.psp_if_ver,
>>                        &adev->ualink.info->station);
>>   +    if (adev->ualink.loopback.enabled) {
>> +        r = amdgpu_ualink_loopback_init(adev);
>> +        if (r) {
>> +            dev_err(adev->dev, "Failed to set up UALink loopback:
>> %d\n", r);
>> +            goto error;
>> +        }
>> +    }
>> +
>>       r = amdgpu_ualink_drm_client_create(adev);
>>       if (r) {
>>           dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
>> @@ -1044,10 +1078,22 @@ UALINK_IDBITS_STORE(vpod_config,
>> vpod_active_accels, vpod.active_accel_bits,
>>               AMDGPU_UALINK_ACCEL_MAX);
>>   UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
>>   -static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
>> +static struct amdgpu_device *find_peer_adev(struct amdgpu_device *adev,
>> +                        unsigned int accel_id)
>>   {
>>       unsigned int i;
>>   +    /* In loopback mode @adev is alone in its physical pod and
>> owns both
>> +     * the exporter and importer accelerator IDs. Resolve them to @adev
>> +     * itself. This also keeps resolution scoped to the caller's pod
>> for
>> +     * 1P4G, where every loopback GPU reuses the same accel IDs
>> (0/1) and
>> +     * a global scan by ppod.accel_id would be ambiguous.
>> +     */
>> +    if (adev->ualink.loopback.enabled &&
>> +        (accel_id == adev->ualink.loopback.exporter_accel_id ||
>> +         accel_id == adev->ualink.loopback.importer_accel_id))
>> +        return adev;
>> +
>>       for (i = 0; i < mgpu_info.num_gpu; i++) {
>>           struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
>>   @@ -1059,6 +1105,31 @@ static struct amdgpu_device
>> *find_peer_adev(unsigned int accel_id)
>>       return NULL;
>>   }
>>   +/*
>> + * Physical accelerator roles.
>> + *
>> + * Outside loopback a GPU owns a single accelerator, so both helpers
>> return its
>> + * ppod.accel_id and the exporter/importer distinction collapses. In
>> loopback
>> + * the one physical GPU plays both roles: the exporter owns the MP
>> nHT and
>> + * receives all HW traffic, while the importer is the (virtual) HW
>> sender for
>> + * the importer -> exporter path.
>> + */
>> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
>> +{
>> +    if (adev->ualink.loopback.enabled)
>> +        return adev->ualink.loopback.exporter_accel_id;
>> +
>> +    return adev->ualink.info->ppod.accel_id;
>> +}
>> +
>> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>> +{
>> +    if (adev->ualink.loopback.enabled)
>> +        return adev->ualink.loopback.importer_accel_id;
>> +
>> +    return adev->ualink.info->ppod.accel_id;
>> +}
>> +
>>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>                        u32 accel_id)
>>   {
>> @@ -1145,7 +1216,7 @@ static void activate_local_vpod(struct
>> amdgpu_device *adev)
>>       for (i = 0; i < info->n_local_accels; i++) {
>>           accel_id = info->local_accels[i];
>>   -        peer_adev = find_peer_adev(accel_id);
>> +        peer_adev = find_peer_adev(adev, accel_id);
>
> Since it's always single device, it doesn't make sense to go through
> this logic in loopback mode.
>
Makes sense. I will drop this change.

Thanks,

Mukul

> Thanks,
> Lijo
>
>>           if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
>>               /* info->local_accels is corrupted? */
>>               continue;
>> @@ -3809,7 +3880,7 @@ static int amdgpu_ualink_local_import(struct
>> amdgpu_device *adev,
>>       int fd;
>>         mutex_lock(&mgpu_info.mutex);
>> -    peer_adev = find_peer_adev(remote_acc_id);
>> +    peer_adev = find_peer_adev(adev, remote_acc_id);
>>       mutex_unlock(&mgpu_info.mutex);
>>       if (!peer_adev) {
>>           dev_err(adev->dev,
>> @@ -4488,11 +4559,6 @@ static bool
>> amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>>                    AMDGPU_UALINK_ACCEL_MAX);
>>   }
>>   -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
>> -{
>> -    return adev->ualink.info->ppod.accel_id;
>> -}
>> -
>>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct
>> amdgpu_device *adev)
>>   {
>>       return adev->ualink.info->vpod.addr_mode;
>> @@ -4838,7 +4904,7 @@ static void
>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>>       u64 timeout = msecs_to_jiffies(2000);
>> -    u32 dst_accel_id = ualink_accel_id(adev);
>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>       struct amdgpu_bo *bos[2];
>>       u32 n_bos;
>>       struct dma_fence *fence;
>> @@ -4957,7 +5023,7 @@ static void
>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device
>> *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 dst_accel_id = ualink_accel_id(adev);
>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>       u64 timeout = msecs_to_jiffies(2000);
>>       struct amdgpu_bo *bos[2];
>>       u32 n_bos;
>> @@ -5242,7 +5308,7 @@ static void amdgpu_ualink_metadata_fini(struct
>> amdgpu_device *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>>   -    dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
>> +    dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>>       amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>>                         &remote->rptr_cpu_addr);
>>       amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
>> @@ -5289,7 +5355,7 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>       }
>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>> -        ualink_accel_id(adev), ualink_addr_mode(adev), status);
>> +        ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>>         /* Alloc metadata structure for all GPUs */
>>       metadata_size = sizeof(struct amdgpu_ualink_metadata) *
>> AMDGPU_UALINK_ACCEL_MAX;
>> @@ -5362,12 +5428,12 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>       }
>>         if (ualink_addr_mode(adev) ==
>> AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
>> -        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>> ualink_accel_id(adev);
>> +        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>> ualink_exp_accel_id(adev);
>>         for_each_set_bit(accel_id, remote->active_accel_bits,
>> AMDGPU_UALINK_ACCEL_MAX) {
>>           dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>   -        if (accel_id == ualink_accel_id(adev))
>> +        if (accel_id == ualink_exp_accel_id(adev))
>>               continue;
>>             rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>> @@ -5393,7 +5459,7 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>                                ualink_tlb_wptr_offset(adev, accel_id);
>>             dev_dbg(adev->dev, "init from accel_id %u to accel_id %u,
>> rb_size 0x%x\n",
>> -            accel_id, ualink_accel_id(adev),
>> metadata[accel_id].rb_size);
>> +            accel_id, ualink_exp_accel_id(adev),
>> metadata[accel_id].rb_size);
>>           dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>               metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>>           dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>> @@ -5804,7 +5870,14 @@ static void amdgpu_ualink_get_wb_addr(struct
>> amdgpu_device *adev,
>>                         u64 *wb_npa, u32 type)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 accel_id = ualink_accel_id(adev);
>> +    /* The GPUID encoded in the write-back NPA address is the
>> routing target
>> +     * the remote writes the rptr back to, i.e. THIS GPU. It must be
>> the
>> +     * physically-owned accel_id: outside loopback that is our own
>> accel_id,
>> +     * and in loopback it is the exporter (the only id the single
>> GPU owns
>> +     * and can receive on). The importer is only a logical source id
>> for the
>> +     * forward path and must never appear as an NPA GPUID.
>> +     */
>> +    u32 accel_id = ualink_exp_accel_id(adev);
>>       u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>       u64 wb, npa;
>>       u32 offset = 0;
>> @@ -5978,19 +6051,19 @@ static int
>> amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>                              &peer->shootdown, &tlb_wptr);
>>       if (r) {
>>           dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed
>> %d\n",
>> -            ualink_accel_id(adev), remote_accel_id, r);
>> +            ualink_exp_accel_id(adev), remote_accel_id, r);
>>           return r;
>>       }
>>         if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr
>> == tlb_wptr) {
>>           dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same
>> as remote %u\n",
>> -            ualink_accel_id(adev), int_wptr, tlb_wptr,
>> remote_accel_id);
>> +            ualink_exp_accel_id(adev), int_wptr, tlb_wptr,
>> remote_accel_id);
>>           return 0;
>>       }
>>         dev_dbg(adev->dev,
>>           "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr
>> 0x%llx 0x%llx\n",
>> -        ualink_accel_id(adev), peer->interrupt.wptr,
>> peer->shootdown.wptr,
>> +        ualink_exp_accel_id(adev), peer->interrupt.wptr,
>> peer->shootdown.wptr,
>>           remote_accel_id, int_wptr, tlb_wptr);
>>         amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>> @@ -6161,7 +6234,7 @@ static int
>> amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>>       struct amdgpu_ualink_peer *peer;
>>       struct amdgpu_ualink_ring *interrupt;
>>       struct amdgpu_ualink_ring *shootdown;
>> -    u32 src_accel_id = ualink_accel_id(adev);
>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>>       u32 dst_accel_id;
>>       u64 npa, flags;
>>       int r = 0;
>> @@ -6284,7 +6357,7 @@ static void
>> amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>>   {
>>       u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 src_accel_id = ualink_accel_id(adev);
>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>>       u32 dst_accel_id;
>>       struct amdgpu_ualink_peer *peer;
>>       struct amdgpu_ualink_ring *ring;
>> @@ -6371,7 +6444,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device
>> *adev)
>>    */
>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>   {
>> -    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>> ualink_accel_id(adev),
>> +    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>> ualink_exp_accel_id(adev),
>>           ualink_addr_mode(adev));
>>         adev->ualink.msg_ctl->send_halt(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> index 3e4f2d18c83c..cbff60193383 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> @@ -93,6 +93,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN        0x1
>>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN        0x2
>>   +/* UALink loopback support.
>> + *
>> + * In loopback mode a single GPU loops UALink requests back to
>> itself for
>> + * manufacturing testing. The GPU exposes two fixed accelerator IDs:
>> it acts
>> + * as the exporter on one and the importer on the other. Loopback is
>> enabled
>> + * with the amdgpu.ualink_loopback module parameter.
>> + */
>> +/* Fixed accelerator IDs used by a loopback GPU. */
>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID        0
>> +
>>   enum amdgpu_ualink_conn_state {
>>       AMDGPU_UALINK_CONN_NOT_READY            = 0,
>>       AMDGPU_UALINK_CONN_IN_PROGRESS            = 1,
>> @@ -321,6 +332,21 @@ struct amdgpu_ualink_msg_ctl {
>>       int (*send_halt)(struct amdgpu_device *adev);
>>   };
>>   +/* UALink loopback mode state.
>> + *
>> + * When @enabled is true this single GPU acts as both exporter
>> + * (@exporter_accel_id) and importer (@importer_accel_id). There is
>> no second
>> + * physical GPU, so exporter->importer messages cannot be delivered
>> by the
>> + * (single) MP nHT and are instead emulated in SW by feeding them
>> back into
>> + * our own IRQ handler via @wq.
>> + */
>> +struct amdgpu_ualink_loopback {
>> +    bool enabled;
>> +    u32 exporter_accel_id;
>> +    u32 importer_accel_id;
>> +    struct workqueue_struct *wq;
>> +};
>> +
>>   struct amdgpu_ualink_mgr {
>>       u64 npa_size;
>>       u32 psp_if_ver;
>> @@ -335,6 +361,9 @@ struct amdgpu_ualink_mgr {
>>       /* For remote interrupt and shootdown */
>>       struct amdgpu_ualink_remote *remote;
>>   +    /* UALink loopback mode state (see struct
>> amdgpu_ualink_loopback) */
>> +    struct amdgpu_ualink_loopback loopback;
>> +
>>       /* handle irq from ualink client of remote GPUs */
>>       struct amdgpu_irq_src irq;
>>   
>
