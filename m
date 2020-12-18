Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092FC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD102071E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD102071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D906E202;
	Fri, 18 Dec 2020 16:23:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1903D6E202
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 16:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQTSIuXcX1KG3QnWkcL9Ia1oref28mVqdHEBecrpwVuSGud15Wf0O29HFVRjA7JBboMS2qs0c6YhrOcll72mglWylNqa3jEv6J6CgIBeDy2VDjBcWJD6cii5OSWqYwNXsv4oTip1GDFDGX2R6wcxHU4VjGiDUkCvkPGNfx3Mju4QIxhkjeT33geIeUTOn7CYWSUf2dDCuMHBdhhmaho5T7TAhwfxPZ8vHB5ZeGsxemSaerEHrOycXRvcIV/MDCSuAjk4lr/67T58rFguWtRqqqAL+zuJ0IWAk3Ww3iHaoygS3mlAVpS9Jkce1CbbrZnNJF1a+B6c77tJcp4LsuhLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEXmrMbRiXYoOMtTEvyk+gLM8sK4g47YWyX0tXx4CmY=;
 b=afRabscHnwq5WjTgO9e96hCSbLPFirtcPq3p943NHRCzF6fsAriGwkkuyMs7O/a1owWuk7sPvOKpT7Vx+aoW+42rs7k7rcz2luBk3NkrAlQcavn4rdks8gMC/l4iaH7BeL2mj4CpdIfY5pvtOfh0i7y1REIsHEX8HTwagzZJoDeUyu2u8j1MvvVZGYYur+1EeejZXrSzPkNlNb4uC7ae/5vgvA82UNdWrayu+QWjeeAVMF1uCIGMa3TFEWN+3TvHf9E7WV2zQ+PyWRMXlhPvaeb7d/3e2dKioeRpPIYoLR6sgRsToPTV7q8mrAOXjZ8Lfj8cB09zD3oxXnS9+V7bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEXmrMbRiXYoOMtTEvyk+gLM8sK4g47YWyX0tXx4CmY=;
 b=oLBglC+lN4VzYRXdTvxYxhcsDgX5OGDpcYYtYyVOqyqY1Oex7gzpQrjHt+ALYGsWKYU7exclWET/bcqhFgK6bEu8VIfbnijH42oGfi6RiAH/BWGRFwHnIBhUMP2lhXHm/Wfyeuks4S3v9X1UhhHcBayDUC2UDZilJOGAf9gS3bo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 16:23:08 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 16:23:08 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix a copy-pasta comment
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201218162030.20662-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d212ba55-ab65-e727-76a0-03fc79fdbea1@amd.com>
Date: Fri, 18 Dec 2020 17:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201218162030.20662-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.45.20]
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.45.20) by
 AM0PR01CA0101.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 18 Dec 2020 16:23:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e556324-0d79-481b-10e1-08d8a37134ca
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237419AD1A71E04E4312BCB38BC30@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV6in4gKxNm3D3owCSMVCKORFc35C1oYpfCb8KQUajYyjICXhRwvx+apB0ujgAGPPCk4hpmh6xIJKLcuDt4kxsejm3rCWBEXkQ9LQKKxkujFYWgyTHkI2+HsbKNS2wFzwtSuI7oCFqVsBYvfsqqGKj+dL/3XJ519lwgl7P6Xu4qmEq9ylaR6N9ma608QAnqYev0v/U4nmqtQbddL3/jJT/PWKinhFuvGeQ97ATu5zunyG+9XFX6cZ2T4WLFgB0qyKrR3oCHYKGDDDOjyar9v1CVGcp/lCJgCEhOjPIHDSQWc5zvYS8hNa6T81/+JTH20NdazEog2D0EU+91PRxt0+BeeDosdaKoS1jLbRT0AUXTgIK3leABMXbh++JT9/I+WmLrWD8sDgaZe39T7nd8BXGdCSR+02qaVOg5BFHBYowvnWQ6BhencfNbPVuloRQL2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(53546011)(498600001)(8936002)(31686004)(66946007)(16576012)(16526019)(2906002)(66476007)(31696002)(26005)(956004)(6486002)(66556008)(52116002)(4326008)(4744005)(6666004)(8676002)(186003)(83380400001)(36756003)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dCtYYVl2bXcvcDZCQlI0dUJtK1BmaEsrWTUyaWJKVDZrZ0ZaWUlOWkJaWlZS?=
 =?utf-8?B?WWxBSW1CTTYrYUVvZ2pDU3ZHRHNJZDY3Szk2WllodDRDMEFqVG1sbmkyWWxQ?=
 =?utf-8?B?YUFadE42a3F1V3VONjg3ODEvcHkyZjJSeWRNRGd3WHhIZ0RpWHlXc1MyVnh1?=
 =?utf-8?B?SmdzT1o4SnlCWXhkNGlaelQvT0dWdm5PUWg2djRZQ01HVlg4bGV3bjNMN0tZ?=
 =?utf-8?B?UWtNUHl1ZmNhVTJnY2hlT3pUN2Z4S2lQYTUxSk1VVVVWK0VCNldjZkRmcThn?=
 =?utf-8?B?UzFpRCthN3ZvcmtweFF2RitWdU90VExtWDFLWUhMNE50NG8vZ2J0T2pta0JT?=
 =?utf-8?B?K1VpblYrMk9ZWjFHN3Z0azAxZzV0cTZWNHZjN0p3S09FTkNKeHZ6WTFwTTIz?=
 =?utf-8?B?MnR5TjFIQzhLdmQzZXJrMzJJN0Q0bjE4dG9waDhIUVVXR0F1b2luSDZnWThF?=
 =?utf-8?B?dHNpUndYUng1MVpwdGI5NXM1VWxiK1Mwd0FVTXZScjB0b2dnWDgrS2tYQWFj?=
 =?utf-8?B?U2JoeEQvazRUL2NFMlFveDFyMURhVlhia2tPdnN0NVo5YTNXNWtSUnJHVnFH?=
 =?utf-8?B?dzc2TW1jUm5KbUNRQnR5djhjVlNmcWNQaTNRWWhibTVJbThCbHdreTRKcDUx?=
 =?utf-8?B?ajBuQUNUTUxVaXA4ZStZWGpldUV6aTZDcWpsSVFvMzN0M3hncVgrdlRJaks4?=
 =?utf-8?B?enZvejVjOGdVU3ZtNnhGbVJ0ZW0valREQnZGTmhsNG5PSFJ0UW5sanlreHNq?=
 =?utf-8?B?TDdhVWZvcERMbUwraGVkL1FWNFRIa0ZEUzQ3YzdDa0VlL2FpVTduWkpnN3Ry?=
 =?utf-8?B?dlJxUXdWTkZUQ1hwUis1R25PNjRMTnhZWUR0eDNYYUdLVUdnWS9XUjBQVEhZ?=
 =?utf-8?B?Wk1WMU5nd3JYVjRKZFl5ZCsvYlhaNndKK200SHpIaFZjNzZYdExza1RaYVhh?=
 =?utf-8?B?UDNCTFYrUnAxSSszQkxjcW5vNnNoRkRmZXFOUkxRR0w0ZVJKRTh0UTFOZDd3?=
 =?utf-8?B?TlQzVFpUQUVtZDVxbGtSYWRablA1M2FjeG9Bd2RWK3pjS2tidG5nT1dQMDBR?=
 =?utf-8?B?ald0ZmhrbjJvZWU1eFlzUDUvTWxFMjlwZjAzbWc1UEdJZmhURHY5elBSQnQx?=
 =?utf-8?B?eDAySGdRVG8vc21GK3RpbC9MKzNSR3RFNTVWV1NBd29CcElBL3lzYURsNTV6?=
 =?utf-8?B?VFhlS1JQeHhLWk40ak91K21qME1wSVpVY0lObmpQcGljVzBTNWZYTmdMVjFR?=
 =?utf-8?B?d1h6MW56TEVEbnBmNGxpUFFPcDlrYjh3QmRuajJiYzNXNkRwWFJRZ3VncGd6?=
 =?utf-8?Q?qgNAc3CaT/lMfvrCu4cETSMc/vM269w7In?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 16:23:08.4215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e556324-0d79-481b-10e1-08d8a37134ca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeBNVdm0fiGDNqNQG5EJVl2d8P92Kfa+RwAJD0W9OspN+oVgzYSCEeyoUqcRyLmhE41fMiqPf2iylP//loIN6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 12/18/20 5:20 PM, Alex Deucher wrote:
> This is not a scsi driver.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f194fafa619d..e46646679281 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5070,8 +5070,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>    * @pdev: pointer to PCI device
>    *
>    * Called when the error recovery driver tells us that its
> - * OK to resume normal operation. Use completion to allow
> - * halted scsi ops to resume.
> + * OK to resume normal operation.
>    */
>   void amdgpu_pci_resume(struct pci_dev *pdev)
>   {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
