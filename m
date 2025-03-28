Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EC5C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 08:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8231F10E9A1;
	Fri, 28 Mar 2025 08:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wowq93V8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553E210E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 08:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y17JiMcyCytDggLDfXHCQ2ombZf3+0+JWZLYvQdcdvaxCAwXU3c9bJtsyNv2qABnuX6cMHnsPWeXpWte2OMNlsdqTtTiKzY117XQ3iHU5+avpXOb/kqVZ7tdtyqc1uA0LFi0H6yXffTTV961/+HqRqDDs4NNjLWbw5HX50qgjOGIQModKoU6adeWzPwMqY3zUwfUDZbFO2iOfzmameC8sBzSsm26rBE8mgg/varR9qUQ7G832C37dUEWXq0nWiu9VBK33inRqnTZc7rvnxwdP93kawImzsarTMXKumVViX8KiT2ebEr3+HwYuneNkuYZ2aWaYe078MumADS8CS22Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S1wC2sPf/GpwWCL2LX6KUs2EN4xCn+5I4tbaCM1Jrg=;
 b=MGUdUml7FmwvnDqgDfWHeFZoFiRmwmrJJ/eP7FETTkRKcM/3n3eoD9l2lHmWU9oqFAZ0H8GSeN8R8mileG1OZSIXS5YPThj4duSA6m5Jj55boD5tCsxvZtMROxmkZxop4VDLsPiohgs6CMJA+maZiX0ow+iNfVFIIQ77N7P77NE6CVUPTWTVoJDshqHircnXmVHn9CblqZ94MpiHpattGlMECGU+zMlkw0stgeeNqqVzD4VCElk3uSZgb1KazrjJFPbESdywjIx2oIdTTjOGPDk96U0Iz9bxYDSmtI0xo2WzJaeal4MGENFqPaEWBHeycF93fUeBq1HRqdZnSFjolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S1wC2sPf/GpwWCL2LX6KUs2EN4xCn+5I4tbaCM1Jrg=;
 b=wowq93V8wVA+Plpn8y9x0XO1RIK6/qZl1UPLzC/e9DypfpoJPDXQf+DQzkQSkqgXUmfvKBO95/K+hGeh4ptJCLc78PcrO4YvUID2dgdeB2Ad/0qyzYihIVwVMhcHGAYjxxrFUB0hhJU4kH+V893RkV7Hop4BTFfbxNzs8MtHhdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.50; Fri, 28 Mar 2025 08:49:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 08:49:43 +0000
Message-ID: <65ca3ee1-e797-4542-adc2-a4c511d779c7@amd.com>
Date: Fri, 28 Mar 2025 14:19:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add basic validation for RAS header
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Asad.Kamal@amd.com, Tao.Zhou1@amd.com
References: <20250326080329.410009-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250326080329.410009-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000018A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::55) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0df256-c596-460a-1faf-08dd6dd57c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVVSeldDNEJVeGszU09Vd0xKRnRQUTc0ZnpzV3o2V0hxMzRqZFZkMGIyb1Vr?=
 =?utf-8?B?K0tKaGgzRTZuN0R2OXJCTHdjOHY4aGV3NWcvaHJUM2trNDN6OWxIYlJVY0Yy?=
 =?utf-8?B?RFhkcFQ2MDkxaGJaOGI4eW5kUHNTWmI4N2wwVFRlMHQ1NVRJM0cwWEJnbGM2?=
 =?utf-8?B?WXJOUWFPU3JxaGtwY0xCcGRCU21QZmZDWHRNUWNoMkpOQ05BS2YzNmkxTHhv?=
 =?utf-8?B?bFJFY3RZbkJ1RGc1Q1UrNExRNUtHNk81Z0RValhpMlN1bi82WFlMNnJjR2xB?=
 =?utf-8?B?b0ozVDB0UUQvUXo4TDVJaXBuU2NIRkxqeTUzS3VOMWtZVElOWVJaam1UWE83?=
 =?utf-8?B?RzE1ODBCYTVNNFUxMHVCWjFjcVgvLzNaYWNRVGwvTFFYZSszQS9CU0I4ZlRC?=
 =?utf-8?B?SjVTWlFtbU1HaXlJeUQ2ZGhWY2szSm92ZHZubXkyMEpsd2MxdUQwSjhZSVIy?=
 =?utf-8?B?S0IrRTlEYnlDbTdxNFF5akVhb1Fyem1lRzY5SEZIMWRJM2swNjdSSm1BdXVO?=
 =?utf-8?B?RDQyTWhPQjJWSzNoZWx2L0I1VXB1T1dSM3NmNG9rbExqQ3RobWhuVXdUM213?=
 =?utf-8?B?Tm81cVBmRVp4VGcvZmdkeVRYM0ZEMU5vZ1dZTGViWE5NQWZqZlRGaWpWcC8y?=
 =?utf-8?B?aVA0VWRIUGJPcVErS2xIUS9ONnRrZkkvWjNVQkVqcENEdWVnVlcxckc2Qldy?=
 =?utf-8?B?amkxVEVlYXNreHZkalZ1MFR6K09sdFFWNVB2ZU1QMzVKREgxTmdrcjd5aXJt?=
 =?utf-8?B?Z09tV2U1OVBpOEVReGRmaGxUMUVzNHF6UkdHcTJQYzJpQ2dkbzhSS1V1VmZk?=
 =?utf-8?B?Yi9OZkFWa1RKUjY0T0dlL042SDNNdmt3blFNb1VlQ2pEc09WUjRqZlVmZkFM?=
 =?utf-8?B?TG9kb2IvRHhCZ3g1QWhIanErSlM2NGMweWw5V3Q3T1Z3bWFXdW1DZ1E2Rjkv?=
 =?utf-8?B?NldwcGg0K3NJWHU1VHN1UkhiUUkxT0JRVlNKbldDRGYyODV1a3J4RmllcW1r?=
 =?utf-8?B?ZWRCVm9hNjE4TkVpM0JpNFcvTEQrMHNEZm5yaVJrS2hIV25KZmtWMmJ5allv?=
 =?utf-8?B?N09zbTYzdVl0WVIvTWUvb0VzS1FZMmo4WmtRSkJRaDlkV1hLSVIxS1VwQWc3?=
 =?utf-8?B?L0Z5eGVQcS9YaTNQc0YvTERFUXhsK2RNRmVFUWg3dzBHZVV6VHZ5WXNoclAx?=
 =?utf-8?B?eGpMQjhrS2Z2em0xU1g1Z0JSaThXUVRYKzQrUytBNC9NRFhicTZ0YVZrUU9B?=
 =?utf-8?B?RVBjR0VEbDdETnNwdVhhb2dlb2tuZDZvWkR2aHVGS1dHcWZkSW1MM0FmY2Nu?=
 =?utf-8?B?QUFFcDVoSXNyT0ZobjBPZnB4azVDMDBxUEdPMmJGaWZIdDlidFhXWG51MHNt?=
 =?utf-8?B?RndRZWJKMGF6K1J2VTZ3U2pzVVlBaXlSeWxSVFNqanhkZmtvdUpJOTV3R0tC?=
 =?utf-8?B?RWVMUmVLN0FUM3MyZy81Z2dySHdkL3l5VFVkL1paT1IyenNXcWJxd3JVamFD?=
 =?utf-8?B?NUFyRTlIa2RPVTJ3ZVJ5ZkhUbTJsY1k5MHBFUFo2NFpnVGFwVEhXUCtJTXp5?=
 =?utf-8?B?dzdmNkhvS2pjd0VrY1p6S3p5cXRrMlBaeTAzRkRhb2xkcnZGNzlwUHEvZC80?=
 =?utf-8?B?LzZpZ25JNysvUlpIK3lqbWlOUkx2SGV5a1gwVWZ2V2FkaEtFTjRiQnpmOXdJ?=
 =?utf-8?B?UmkrVWNzWEhxRXBqWW96QjVBbG5Xc2NBdlh1a1NBZEcvdVVvajRpTEQ0Myt4?=
 =?utf-8?B?L0JHTHFJMk04b1lQdkFMdXhpK1VsMnYrRFBSWkJ5clRRdCt6STkrdWhCeFRU?=
 =?utf-8?B?Nk1NdUVFTnBUVE5McHJqRldaWDVzQVEwdUdzd21KbGVMbmVVNGhTZ1dxbldR?=
 =?utf-8?B?MDJmd0Q5R1hha1JaNFZDMWNOUXJlc0tLZ0dacjBhT0d1Y0prdnNlWGpRNzFJ?=
 =?utf-8?Q?Rzf3zQNhizY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai8xWWNCODgvRjFIYmZtenc3T0VKbjhvZlJpZmJ2bE5xS1pJUCtqQ1FWSXpE?=
 =?utf-8?B?RE9QTnBGTHQzbktzMnplVkVCTjMyc0ViTjZtVWQ1SWwxOVNZTS9nY3E2dDhv?=
 =?utf-8?B?T3dYTVhmUlM3cTdhbW1ZejV2Q1VYZ205bUJhWXJkZDc0dWZjbXVMZWcvMDJy?=
 =?utf-8?B?OHF4bXlwRU8zV1ZkOEJ6Z08zOXRSMkZwTWNsVFdEY2hZZ0c3TkxsK2pQemdX?=
 =?utf-8?B?SG04bU96TGZ2OXpRUDlPa2dacVY2M1hKRXcrM0YrMUMwNldHMjlYVGNDOHl6?=
 =?utf-8?B?QXdzL2JqRVFCY0RuLzZGM01VYnNsMUJsY1JtS3dyYVFMU2FTREV3bVFPci9W?=
 =?utf-8?B?VDRYN2szaEMyVVBoU0pxYmJiOXJoa0Rob01QNVRFa1Jya0NGLzV0d0FJU3VH?=
 =?utf-8?B?SVNUS3JvaHBudkp0Wk9FVVFON2docWFDNmI1Y1hYSzUwbC93NkF1bm83UXQ3?=
 =?utf-8?B?NERSZzAvcXRMbkJVWFhpNm9rYW5aNmF5QTZyWUpzV0NzaVpWc0x6RWQwR0d0?=
 =?utf-8?B?OEQwTTlMMXU0ZXk0Q1lGcllnbW4xTnV0WWFCcWpzT29xY0pTZzJIZ00wdGV5?=
 =?utf-8?B?SlhJQjdVTDhmZVF3aHFNQk15ZURnL3VkZG5QZkZSUmg1TDFxVFBlTFBsY3Jx?=
 =?utf-8?B?TmRkVy82Vk1LZVhjWjNFa29ZK3ppb0VEc3J0dlQwTjB6Q0pwK0gycFVCZko2?=
 =?utf-8?B?VVg2QUcvZEdCc3BQSE5EVDczcWhvYW5oR1ZvdGxyTkYvVEJmWnFYN05Femlo?=
 =?utf-8?B?TlJwZ1hqSlRaOFcrSHNwcEgxZDlDb29ZbUNIc0x6a20wc1hPeEtOdU9PQVJQ?=
 =?utf-8?B?cG01UXlzS0NGRm5GYlFFWUpyWi8rLzhUNnVNU0lRTzVyUDk2SVVHUWFVV0xJ?=
 =?utf-8?B?K25FWDVmRFU2ZjNHT05rbUx5bjBjRTFoQ0NFSDk5MmlBTUZLWTlSd0VESFc5?=
 =?utf-8?B?TmpEYmVpVUY3NVRHTE1jU0I3WmFHTHRQbG5qM1N2M3lEVXNjSjlDa2o5VUda?=
 =?utf-8?B?R0ZYNWovbGpMME04WC9JTjhOVURLK25Hc0pBVGVmVDJiWG1iT3VjUVhnUXBP?=
 =?utf-8?B?Qk9Rd3luSEhRRE91eUhYOUoxM0RJZUJINXNDTWpQUC9Eb2FOenRvV28weXhD?=
 =?utf-8?B?bVdBc3dGUGlaMFk4eWhxU2xKRVpTdjZleVBBaVY4Ykwwc2E0NUFtU2FPWHFE?=
 =?utf-8?B?ZGkwcExLWkNta2pQZVl6dnBoMkRiSElNd09IYzlhWmVPRTNtWXpWZS9JS0Ew?=
 =?utf-8?B?d1VRME5MWHpKektDQ0srVVZmVTRISVBTNmRlUzZ3SGxCVVoxTzNXOVVzMUpo?=
 =?utf-8?B?OS9oMG9JMnpwWlNqNi95eDhUY1RieDFpQ2tubWRJYTRxUmtOOWt5WDcrQTd5?=
 =?utf-8?B?Zjh6bFN0SVNyOUhISS8zN2w1RitXSmh6TE1aaFB5M1VuM1NIdjJsTmFpT2Q2?=
 =?utf-8?B?T3dTV0dTd2UzUDJwTGplUnp0UWdXV0NjbCtBWU42MVUvaDZkVEdIL0JJT3Vt?=
 =?utf-8?B?TS9SS0tIeWVQeVNSOHZuREVCWlRPUlJOSXFRWjltdXUzMDUrQmg4TU5RU01u?=
 =?utf-8?B?UXcybzVrN2xSY3hSYS9tMHFJS3o2YnNsNm9hSHRxdHVWclRDT3VRL0pNWnY3?=
 =?utf-8?B?bW5DdG8zSFk5NmNUOVpsbWUwSE1VaTRzaHFYcU0wMFIyZ3JaeldJQkNpVmtW?=
 =?utf-8?B?TmFLdnQ4bXYrZ21GcEFZcTY5UDhManQwRlEvWnZ5S0I5L3cyck8xaFFrNXJV?=
 =?utf-8?B?ZXE5NVk2UFpzdHdwNTZ5VlpWd2dzMFBMcUk5QlZZYlg3b3JHVUQ5Vjh0VFli?=
 =?utf-8?B?MjZrd21WR0pDQUJORjZHNys5aTJGYlQzYXFWbVhtT242YXdRYmlJaDk1T3FS?=
 =?utf-8?B?aFJJMTNTQ3d6ZmZKR2VHcG9OamtiRGxELzBUcVVlWVJvZlFUcDBjV1h6NGtk?=
 =?utf-8?B?Lzd5MUNZMHE0anIyKzZSeEJGNFNUR2dEdlhrdFpBMjVoaUdTWFF3QlJxbHQ5?=
 =?utf-8?B?UW1KeUdvcjNDSllXMVI4b2RIOGVTeXAzSXNPVmNGNm9DaWx5STJoS3BVeHhB?=
 =?utf-8?B?aUd6Z1JyY3YyeTBJMVYyZ1hpZ1ZCTnllNU9MOENpYWwxUWp3akliQUV4aElF?=
 =?utf-8?Q?7oc/f65RKXu/HL2eagsYYL5GM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0df256-c596-460a-1faf-08dd6dd57c1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 08:49:43.5715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V9qfKBKreP4vse0/zP/qqU+9qpkulvk+9cGK9Bzg6pggrboArvTAK1iLYaEkS87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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

<ping>

On 3/26/2025 1:33 PM, Lijo Lazar wrote:
> If RAS header read from EEPROM is corrupted, it could result in trying
> to allocate huge memory for reading the records. Add some validation to
> header fields.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 0ea7cfaf3587..e979a6086178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1392,17 +1392,33 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>  
>  	__decode_table_header_from_buf(hdr, buf);
>  
> -	if (hdr->version >= RAS_TABLE_VER_V2_1) {
> +	switch (hdr->version) {
> +	case RAS_TABLE_VER_V2_1:
> +	case RAS_TABLE_VER_V3:
>  		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
>  		control->ras_record_offset = RAS_RECORD_START_V2_1;
>  		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
> -	} else {
> +		break;
> +	case RAS_TABLE_VER_V1:
>  		control->ras_num_recs = RAS_NUM_RECS(hdr);
>  		control->ras_record_offset = RAS_RECORD_START;
>  		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
> +		break;
> +	default:
> +		dev_err(adev->dev,
> +			"RAS header invalid, unsupported version: %u",
> +			hdr->version);
> +		return -EINVAL;
>  	}
> -	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
>  
> +	if (control->ras_num_recs > control->ras_max_record_count) {
> +		dev_err(adev->dev,
> +			"RAS header invalid, records in header: %u max allowed :%u",
> +			control->ras_num_recs, control->ras_max_record_count);
> +		return -EINVAL;
> +	}
> +
> +	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
>  	control->ras_num_mca_recs = 0;
>  	control->ras_num_pa_recs = 0;
>  	return 0;

