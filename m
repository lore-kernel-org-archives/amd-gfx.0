Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB318C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 11:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73245613D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73245613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298426E141;
	Thu,  3 Jun 2021 11:08:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6747E6E141
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 11:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLMWBvF5cMb1ic65TR9la0iMlTPStCKBodClc81lpTmkbK7DZI/DryxfPINgBVlfC+LC+bHSp7mI1MUShtbqBKBYxLDaFc66XrjZ/HiE6oWxWMfQi1bhZG1tgP4M8vkkppouh8QU8V8HEL7dGXUT61Ypu0l7lPmv739AaII/cLhMS4DNDeQQkvK0RSd0HbK/YJcN4QBS3ua918qUo3i+lefyldfeAeINAiW3YUPxLaJZiE89K7+z3ScgI3AGYIZepZAJTb6ejZMy30A7VBdo5MIpGhAecnAstrvQIiOEMsFF4GuB98ERCaOQNXoQAEcz+xCdOZiWTL6pMWs2O99geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmRBmWvfMDzhkHOdRH0YOqqW3gdahMseobJGwV0dcgA=;
 b=OqNKypNvR4S5q9eE4mAOtu9c8kpvYQj+BOhL63jWRqDOr5f3G+JvptWazZSPk71bMvB3IN75MvOT4ckdjFyXJdBzCt142qB8T937LTackLMTFpk1ppngJd2kkDaPZlXbJ3fe2CfUZgcB9+R/OSESpEly1v89ks7F+YL4K7XmZeiLs9Bg/PdP5/ShyYB/f0K5g+JMIHIvjRFVuysUzIrRxTejXKzym22TDg7yh8sLf3sF61WaK4T9WJh+pCeAOW5QervRtR54dVhAZyaiSY/lNz/pvwLmhoQtFblx0KpL5DNnNVE98hbv5PwrrXd+PH9Z9FUfPeroF1kBZ/X92P3uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmRBmWvfMDzhkHOdRH0YOqqW3gdahMseobJGwV0dcgA=;
 b=Tz2Ec74pehDvfpwjyhBY/WFstskCyigGPW99gmYMGsKy3zKjGx6mOLxtaqhHUaOYsWJHrgZD5qR13YihOv8fNz1OxjiNs1j1+jMUlpPAe5MdRyJAbywAXko8J1st1+caGrAHgfQqd6K0ZFni4q9L3iIdDLgpLIKAXTazk3KOF+o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 3 Jun
 2021 11:08:51 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 11:08:51 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: correct the audio function initial Dstate
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210603045603.977998-1-evan.quan@amd.com>
 <20210603045603.977998-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <fe0205f8-55a3-076b-954f-9902f876e906@amd.com>
Date: Thu, 3 Jun 2021 16:38:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210603045603.977998-3-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MA1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MA1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 11:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922d4e4c-8c7e-4582-1b09-08d9267ff7bc
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51077FE832852181B3DA2FA1973C9@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u80B25cI5UkUC0VinANHnBGYORbzNIXS29NMWq+/3wYhtGVs3JNdIAyZwt25IqPeYejgAk8i0uVrg/9w88pSxlXEYnoo/COalvEBPvifccuLmBk9zDeX24pCLzhnHT1hyvGSUPv+aJLuJM5r7YJNDeRqsJG067xuXMOo+V009OCIPGpLmi4FilKJetv8OlXBXDS0yHgGlxrNeK4lfc82kFz05qkIh8VC4zesfAgSy+sPS+3FDJJWDI94dP3jdeoicx8k3+DnftUDDvsRWNbw94lZQave/ao/U3+Iw7LCajMEi8ol41ijZXuWoTIGjKOfAN38DGXCF4AIgE8HjhvmXIHbiUHBJP2YkNLG9+cL7c7gTRBkT+OsLW/NyTP2AX4nUqSB4yVtp4iTPdpX+9fw8ps7ir+uCrW7joM3670R5Hy7JS0J+UJGwwUiHFSedYWyUeTLEQM+kpViIX7e4q249sBWTNVVyJGTJZUmN354wU1/WW+9aLi1eyIWXROmIik6DQoQ2130gI3AHLeMayvQ1bUWTrCJt3xRL/h9oJ574pyuQc5pX9zcaOhhCFvgpTEOQ/rpRBRUlAJ5dvhVd3hI7X37uVnVNRZb/dWlq9lbQdigS1mDnmBxZijgj/+yfARiOGKEdSy8HtusZfloYo8OSUY9OPSFpWVN15h4oQ2+jqFAPUWQCCARXxUFAzVBuxC+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(2906002)(6486002)(8936002)(5660300002)(316002)(16576012)(26005)(53546011)(4326008)(956004)(16526019)(2616005)(66476007)(66946007)(66556008)(83380400001)(86362001)(186003)(31696002)(8676002)(36756003)(31686004)(6666004)(38100700002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWJaWDFqamFXeTRsVVlRL1R1bzhyMVMveEpwajQzdUlCRWtiTnRnMVBvQ2lS?=
 =?utf-8?B?Yk9TRjFlclZZZUJIUDRoMXBJaGt3Nk5IcGJrTmgrMmxEOTE0SmR6TDJtbGtz?=
 =?utf-8?B?MUhGSTZKZzQ4N3RWaVZUbU1uODc0dEpIaVkzMVhNZ0p6bFFOeFgwT2VUdmRo?=
 =?utf-8?B?Y3VaWFRtVHlBZUx1dE5VRzNLUTc1WFVDeCtpaURLT3I3d3JjM3pRS04wZXJw?=
 =?utf-8?B?dzErR3A2c2g0UzRvbUJxczJJdmRjcW9tMGFPMVVSZXkvTzJqenJ3L3lCUWU2?=
 =?utf-8?B?WkExa0FpbUJ2ZFV4eDRiVkQxbWZ3RHl5NDcrcmlwekZ1RGMyWk9FMy9abnQx?=
 =?utf-8?B?ZlkraEI1d09zVWR4eTdmTndobnQ2MlUvUGt5b3AyZFF6QkU5UjU0Vm1iL2x3?=
 =?utf-8?B?MldFWURjVkgyQXBZcE53NVpRNnRaaHcvTDBHTCtKMjc3MzRONjNPZkRMbVVr?=
 =?utf-8?B?WHJLdDR6anVzTENmZVVCNk9mRHowbFR0MG44VTQ5cUtVV0tIK3huaUUvYXN4?=
 =?utf-8?B?UnJoekNWWUtxNE1rWGsraXFkUERHSUNtZmVYa2tVc0MwRUpibUlQWktJTmNW?=
 =?utf-8?B?S0VlSURKblZsc05kemtJa2xRYXJKbE5LOUh1cTV2ZDErazFabFowQUJ0czZ2?=
 =?utf-8?B?bE9NeEZ1TGV1dldhK2pYNG5TcXkzcUVzbFl6SXRLOXNIVVp3cW1LdHYxWXJw?=
 =?utf-8?B?WHlTbkZUc1dGNkpvdGNlemN0MGQ4YjJycDFuWWU4Ym00U1NCSVI5R0RCOTd4?=
 =?utf-8?B?NE1XQURrWUtKTTVUeGtVcDRGd0NJWEIzb3NGbkVGZ2tRUXN6YXZ0Q1liL3NC?=
 =?utf-8?B?NE43VUd1WUlmdEowTXdxU0dTWmtTVnRraWJrRXdYSmJ4Mm91YnZtQzBXV0Ix?=
 =?utf-8?B?bGxOZFZSMHBrUmVXTW8wR0JkYzVNdm9kOGIvejZmVnhTSmVUeDF5VU5LVDZQ?=
 =?utf-8?B?a0NyYVcybW42akxMSzJGRDhzaHE2Ym5HZHZrWEdrTmI2R0dHWHpXbzRXeGU5?=
 =?utf-8?B?emNxTzh5Umo1a1VDNTZuUlNrdTJibWVPbnhPdHNJN2RId2k3MjJlS0NqL1Jn?=
 =?utf-8?B?dFhVSE45SDlJeS9DL2pLcGIvU2pTTFlmWFFiaHFFWHpXMG5JY3RJZ0F4QWhx?=
 =?utf-8?B?amMxRmozQVArTG9zZWZSbVdYQUsvUFVPcTlmRVo4VS9nSHhMb1FaaTVpaDZS?=
 =?utf-8?B?MmIyL29QcDNTY3JUYnFWY1VuS0xDZm1IUFN6Z0l0V1F6OE4xVUhKWno3by9n?=
 =?utf-8?B?a25aVzRUSmVwRWsyRk9Oa0xFWENPZGl0eDBROGVmWVZ4eGZESVNxQ2sxSitB?=
 =?utf-8?B?SWx3SnFwS2JkR2RBdmQwUHp4NEdUNDhaM2Mvbk5FRkhwZ2RiMmtjK1RIUXFl?=
 =?utf-8?B?bk1EWkMxUUJ5ZktneTNtQ3ZxaDI0SHplNVAvSmQvVzJjQXlOY2tDYlZoUFRr?=
 =?utf-8?B?enh3UEpCaVpBWGRYQjFFVUpSRnJrR3g4Y21ZZlBxTDY3MVY3ZXNYVEdEMWg0?=
 =?utf-8?B?aEtQenhHWmFFOVphYUdCdmFtYk1lbkZXYkpGMHFpUk41SkJSQ2FZc0RKZ0kz?=
 =?utf-8?B?a0NNVlBvZGRsOXRDRjI2ZkdFc1lXaDE1VHhRNEExcjl6d1c1Mk02MVFBa1Bv?=
 =?utf-8?B?WmR2MDUzUy9GUkFZVUtMR1ptdnB6U241R0tVa0xYOUlHb1Y2S0FDRmJmUVlR?=
 =?utf-8?B?ajA0RHhRbEtIOFl2V3QxOTVlMDRMSU83Mk1xV045SVFzRkhNZGlxUFNGL0ht?=
 =?utf-8?Q?ZrtB/nmAZOUEyAdHVamF/EQBUnNYMrID1bu1aYW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922d4e4c-8c7e-4582-1b09-08d9267ff7bc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 11:08:51.0001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDofyr0fhfuH+CKvup2fTPMa1PxPN76H0kW0O1CsL+Voy9/lk0BLbXpNthEMcysD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/3/2021 10:26 AM, Evan Quan wrote:
> On driver loading, the ASIC is in D0 state. The bundled
> audio function should be in the same state also.
> 
> Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index c354ffa62483..9d497b4f8e34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -137,6 +137,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   	struct drm_device *dev;
>   	struct pci_dev *parent;
>   	int r, acpi_status;
> +	struct pci_dev *p = NULL;
>   
>   	dev = adev_to_drm(adev);
>   
> @@ -212,9 +213,22 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   						DPM_FLAG_MAY_SKIP_RESUME);
>   		pm_runtime_use_autosuspend(dev->dev);
>   		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> +
>   		pm_runtime_allow(dev->dev);
> +
>   		pm_runtime_mark_last_busy(dev->dev);
>   		pm_runtime_put_autosuspend(dev->dev);
> +
> +		p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +				adev->pdev->bus->number, 1);

For the sake of readability, it's better to wrap this as get_audio_dev 
or similar.

Thanks,
Lijo

> +		if (p) {
> +			pm_runtime_get_sync(&p->dev);
> +
> +			pm_runtime_mark_last_busy(&p->dev);
> +			pm_runtime_put_autosuspend(&p->dev);
> +
> +			pci_dev_put(p);
> +		}
>   	}
>   
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
