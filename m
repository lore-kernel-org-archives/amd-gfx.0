Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C301C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074E161924
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074E161924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857EE6EAA3;
	Fri, 19 Mar 2021 19:56:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892C86EAA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 19:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUt3fo/fFPTi8B99+QAjJ2Xe0WrqnXeAU8iaeHOolS7nehAozp0x4xWYWHYTP0kAEVHayKF4Y83Cat+chhBeCorlLn6sw4hyaSzgx4PXzgtbf3h57goKgaOu+AbHK2GzkK+XjqYXZ8UIqDpBW/QMNWz37yNaWLgpg0CkPddYu46Oh3l7Z7SRGteJzy40aNZ0vSixFV6vKcsVNeaC4GAbbex+9EChiH1fFb3GS9eoaqOsoOEP+D/91C5WtTPFMbHsWlv+7i74XOUeSJC2EuINOqvp44zMOmkddY1agQMdPrgY/6ZwWZj2+IGKAcYA8oWFP7MzjtGR8DAhqu6qjJVKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQrkoMiJ4d8X85sqgy6Iye+cRFE/vTc82YMNr/Hnt4U=;
 b=D/fN2Ra0UfLLBkSrpBK2ZY/+kQk1dJl7iC7Daoj669u+pi1SAWvu/i7bFxsov3b0HscgTMj1EmUg35DOpsKwfQ4SSq3MHZb7+8A3pVBnJbof/uMsIl5Ss7rWwyoUhuc9Adcce3hm8GX3m1J7UQguL9Rfyxr1o4waYqMcpQJZMHKhTqRGQHz3/S4OFtFaEzEvd+yLVbmW8fa2+FLCtDhiQzR9bU4k3rMoLsv3CA64d/NfUPtthCgRQxawVtzZqnviiPmZGLsReK2i3TDZgxrzdEF2sBYphVCf0ijR7VwHB3Wrh5lmTo8nOEguWqgJsUvQeSVdi5ijjqjbcOxTB5fkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQrkoMiJ4d8X85sqgy6Iye+cRFE/vTc82YMNr/Hnt4U=;
 b=eTt7ANh4Rv81TJUHHMgJP7ULjb9Mxz+TTAJBWHifBgE3b/FrEwkTSdsQBT4J58jUJT/xoGSSoVe40EJrcyxU5muS2tvLZtm6lcukUvkq6hyBUsRgGtD/guUC5XFZCEAtm4fpyvxD9PbyNvrMR+zNycSP5UgReiXx+pPHsOSxEzA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 19:56:17 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 19:56:17 +0000
Subject: Re: [PATCH] drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210216172854.1738806-1-alexander.deucher@amd.com>
 <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
 <CADnq5_Nk4U0vnk=FXRHJ5U1QEZur2xtTe=+ScC_94tqqOo+e2w@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <2d2c6edb-b91f-a225-75ff-49d6def8ecff@amd.com>
Date: Fri, 19 Mar 2021 15:56:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_Nk4U0vnk=FXRHJ5U1QEZur2xtTe=+ScC_94tqqOo+e2w@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Fri, 19 Mar 2021 19:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4b9319b-5c47-4645-7912-08d8eb110edc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB18056DE4FE9DCF5D78915F4F8C689@MWHPR12MB1805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baGF2mUkKSxXIy6x5/UB/EVcEpxK1Fb1Pdu1Hlu2gfAlw5OJmieX0jEHGzy/q0LUQRWUvfw+F0fSyL5zkhmZ0T52/O1kGiQEKG72kqIkMglveBa8Gz9IUncCBzq3e/bXlsO57R8k8kSrDx5CDemvllJqoUjfpAmUafxWj6FeS4wCW7/5DUQjGtlb9GpOx5358pg4M9fiLyft3vxz3u8r3DfKqLGr++H89YxiN2y8zivO9wUuBEFnCr2VFGNAu7bBgB7k2vW0mDnVX818ehRATUb1VmzKXB81BQhVW7aeuq1YhDJh+8Oip7chqogHaQ5vmKdtPPSE07cCElKGNWu2qrXGTbE83kDtETGIT+uioNT6Z7IHYfb86RidH8EqrLfiOuHF7yZkqJUtAT6kV46wXYPbI4ek2aD47rJQGUGL5c+YWnf2HB/tudEt3WylOvdC5WOQcvAB6v30snVwBPvQXZnbx+RQBgOOJTfcnAJxNpxD3cdiuzBoMzhk92fWI1H7DLLzt3gKV69HcFYbYHK37pd/0v1CGbNuT2HjLBGNC3aMLFx94PPyf3dymcyJ/SUItukmQUw3VHgmGyIHNTZ2RcGma5zBlQmZrVIqqyd9a2TiVEADP27OkRNgTfsXrHp5QAwyyupngFBBylsLfbLg9L2H3dbvyQCratpRXtLvwm/EH8qCxWt6wcy+UF+dxOITZyrzHYjRVEQECORSJKJRsOKhBVrTtNnka935tLBxpK9hbamOldvKbWVZRO5KYJ9GPznIl9P6X3n4KEG0TeDFaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(31686004)(86362001)(44832011)(26005)(956004)(2616005)(31696002)(66946007)(66556008)(4326008)(8676002)(8936002)(36756003)(186003)(54906003)(316002)(16576012)(966005)(83380400001)(6486002)(53546011)(16526019)(2906002)(478600001)(5660300002)(38100700001)(66476007)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?alRoUDc4cWsxMW54Z2ZUMEVWL2s3YXBSVHVVaGZtNWx1ZGMzYXBSMUZ1L3Jr?=
 =?utf-8?B?VnZMZzhBSlhTQ3R5TCtKQ01QaU1SWVNDZGozaFprVWxFU3psSEx6WTVWclZM?=
 =?utf-8?B?YXBvTy9xMnBGcVRkMVJnRjkxQ0ZQbGdpTkNXaU5lRkpqN0NSRVJKL0FDNnVW?=
 =?utf-8?B?aXdnbGFwMGpvNzVXOS9mNDdLbkVlbm9FQXkvMEJBNFZvbUFTRlMwRHF2alRN?=
 =?utf-8?B?bEJuUUQ0YnRieUIrOGIwNWJOSmcreklHTG5qY3U0aUllREQzSHV6RHY1KzIv?=
 =?utf-8?B?QVNyQVFqM09YYlJzakpDWWVrRXlZclpZRHIxQXdhcCtOVlBDZk5yR3ExMVdC?=
 =?utf-8?B?eElmOG9mQUliWEpvQytqcmd3djNZRzBtL2oybXI4djdaZzNiVjFiS0xuMHo2?=
 =?utf-8?B?RFpITXo2R2dFMFRMT0pNb2s0TGhJczd2ZXcvcG5NTGR1MmVLOWZ0a1dlZjFC?=
 =?utf-8?B?SHliWXllRW15MmcvOTQzNi9oN1czY3hNZmZNZVlYcFMwM2JqYlgwbzdiczRr?=
 =?utf-8?B?VFcvWXFEaHppalBLZDUxVTlUeFlvYzFQY2xKMkJDUjZMVFpOLzlXQVIxdzJ3?=
 =?utf-8?B?aGVRUVZ0bDRVYkxJNS8wYnNKMm5aNHFacHp1bi8vMGxMbzQ2cE0zenBjM1dH?=
 =?utf-8?B?MDE0YVhHU1JZZzZjbjNYTGhGY2VrMjh3WnRDd3J5WnVNV1FVc2JySFZ6UkxO?=
 =?utf-8?B?eVdUVmdqZWZPUkNMUld0Vnd0SzE2YnpMaCtpeC8wMmFNRG5aaG85bThVSXo5?=
 =?utf-8?B?bWxwNEdZcDVObjR0WmVmRStLbVJGQTZsSzMvL1p6MzJHOWpSUzZjZHBLNGRm?=
 =?utf-8?B?NTNONy8yOVV3V2FkOFhtMTVxUnU4SjBPZnpyMGxSeHBZMUF1MHpzZjJpNGtV?=
 =?utf-8?B?empxSk1pWk9GbkNleGc0alc5YmFkcFlHV3NFbmV1aktwRWgzNE1ITzA3WVZx?=
 =?utf-8?B?czdXSml3cjh2TVBFa2doQ1dERWI0QzkwaktYb2ZTQ0ZrV3lhUCtiQllZWndV?=
 =?utf-8?B?L3d5STN3YXpzeFFiblJhYUdmRTdQdXhFNnNHbVl1T2VsOU9CTWQ5NUkrMUFS?=
 =?utf-8?B?LzZPa3VaWWRhNmJId3NucHlCREdkNGgyMXhBWXNROXBYTG8vSHQ2TDFWKzc3?=
 =?utf-8?B?ZlBzcVNKZzVJdTNTWmpGQ0dvS0RGVHFuMHZOUEFLWjBlU0hYbnhUYmtNUGk4?=
 =?utf-8?B?RG45K0dXQitlZDR6N0VzQVozVDhmbXVaZXpQYXhaK0VzbUlKVUp6Y0lpNHdq?=
 =?utf-8?B?bitRTXAyb2R5Y0dFQTlBU0dXV3F5TjYycEsyVm5QOExRdVlxRWxwc1lPcUVl?=
 =?utf-8?B?eWRpcEdscTI4VDBIWHRUWXBkRnNKdjNrWXErYUUzNExWQXBsUXkrd3RUMkRR?=
 =?utf-8?B?VFYzRjh0V3JFdnpjQlFaQTdTZFBIUlBzTzl4T2J2enArY2RZdm9LSGdOeWRG?=
 =?utf-8?B?dnNaMysvNkx6ZGVPWVJBYXBoTFJGQmtWWmorcHZPalNlYXc1djJlOFZkUko1?=
 =?utf-8?B?K0k0VEJDZEhYRTk4d1E3c1YzY0UvWDFzcjM3aDFkMmpnNmp2VFk4WVVKVXVM?=
 =?utf-8?B?ZXYrQ09KU2tjaEhKSllFWmpxZ1hPYUZ3TDgyS01QTTJETnRWb0JOYzlsbmtn?=
 =?utf-8?B?eVNZNlhMb3RIYng2SDNRTTZsWmE0YVc4ZVpuRFBlRzJTbmFBMzlsM2ZLUDFn?=
 =?utf-8?B?NmFDTUs5cXh4MTdRcEZWejE1cXNZcEJLYTE2SEw0akthZ3pXWTY1TUZvcm9s?=
 =?utf-8?Q?ZDm4fUZlcyiudKN+7uhta1WhmQmYXM0u7IieYHb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b9319b-5c47-4645-7912-08d8eb110edc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:56:17.0779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrcxKr1kbfYctUtVUyeWuAjOjofxF2WGmanFX29eAPl5m/CsIE83pyLkUNMHerFN7nHbXACT8LgrCtXtqmvoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Igor Kravchenko <Igor.Kravchenko@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-11 9:22 a.m., Alex Deucher wrote:
> On Wed, Feb 17, 2021 at 11:53 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2021-02-16 12:28 p.m., Alex Deucher wrote:
>>> Commit 098214999c8f added fetching of the AUX_DPHY register
>>> values from the vbios, but it also changed the default values
>>> in the case when there are no values in the vbios.  This causes
>>> problems with displays with high refresh rates.  To fix this,
>>> switch back to the original default value for AUX_DPHY_TX_CONTROL.
>>
>> I don't see how this impacts displays with high refresh rates
>> specifically. This is a change that only affects our AUX pre-charge time
>> and was provided to us by the HW team. It does depend on another
>> register being programmed by the VBIOS/DMCUBFW at boot.
>>
>> Before we revert this I would like confirmation that this is the root of
>> the problem.
> 
> Any updates on this?  Can we apply this in the meantime?
> 

Sorry for the late response.

Looks like the other two patches I had were flaky, though I don't fully 
understand why. Let's just revert this change for NV1x (i.e. your change).

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Thanks,
> 
> Alex
> 
>>
>> Harry
>>
>>>
>>> Fixes: 098214999c8f ("drm/amd/display: Read VBIOS Golden Settings Tbl")
>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1426>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
>>> Cc: Aric Cyr <Aric.Cyr@amd.com>
>>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
>>> index fa013496e26b..2f9bfaeaba8d 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
>>> @@ -341,8 +341,7 @@ void enc2_hw_init(struct link_encoder *enc)
>>>        } else {
>>>                AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
>>>
>>> -             AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c4d);
>>> -
>>> +             AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
>>>        }
>>>
>>>        //AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
>>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
