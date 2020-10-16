Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46876C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 18:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC4D20FC3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 18:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FVxAFcsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC4D20FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D206E6E05D;
	Fri, 16 Oct 2020 18:54:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E256E05D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 18:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtQDKF5fULyWtkzavC2SovVz9D0mPW10070/O//c7uftxwffM7GOEG+Cx4YvFb6BRFHOrQu4VbJ9sCYutPXSOTKdnoV/k+lwv/mdgH8ur2Ph8+PDJZt662lsvLx0g1r/7Zz1qPq4sd3V8AlyztaMMwUX7KDV8YnIwBiB85puqcSXWl1tg9Sodc1YUqOcofAlR34jnD8mQHileT3d+elSjlBdFcLccXHKj2WFSSRfjHgKplvn/CDgW+ggX8azaTC8vFwp2zz0FaQLikqMW2/fNhNgliOhWMWX5DO98WRddZc9+XqOACpqfuo8rMKA177ATaGVJjQDIrAZixmATaTYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budeAd+tZjoMJJhJwtd+446U3QIlnKRHQUbxnTKOSz8=;
 b=LJaXIIkKsI7ERJUmZ3MDqKekAOBGelO+2Cw+rYz/u9cJt/NL/1ccyIa42EUWHxmkwIJYSnFZvxmTuVrqvGbruGl8t84JiBq/ZBmXOGD3wkHOL6rYtA7g2OONv7MbDdeno1x7madR2U1GmB0osXbwa8Mi4S1+u/fi46AZzW9cEsf1t2Y20a9nJ13Uf9FxYq1i29j+mpoqqmQ34sGIvrQEa8Soblo5uCD/TtPNR1NtNgFUHPoOjzUs4PZj+HWD/sPiIA8WYTSjkJDwDgAjv59tG49j7yUIuIocrcAJHnlTos5c7qsxY3Nz1U4EOKkfoX+/DQa549n3ge4WzsOAOV4Iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budeAd+tZjoMJJhJwtd+446U3QIlnKRHQUbxnTKOSz8=;
 b=FVxAFcsCvhagJaAdBcrEMZF896insqGpFL6MkV+CfWI5AA9C/l/ZNuygrjTX/78wroiGRxMIveW2TgqGwccmFeFCmhVutChjr2jAuokUn1GbSFLlYFXcBJMEk8RAKihHA2mZFn3+UP398ruyptpmDCpqmkPPuJeMiN/S25vJ4ig=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 18:54:53 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f%5]) with mapi id 15.20.3455.030; Fri, 16 Oct 2020
 18:54:53 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: Avoid MST manager resource leak.
To: Alex Deucher <alexdeucher@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <1602696294-5611-1-git-send-email-andrey.grodzovsky@amd.com>
 <1602696294-5611-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_O=kSbhuBNTjYiMUp8kwgBfU4XUEULAtYEhJz6rE4hyXg@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <064cf348-27ac-4c16-439a-2e2f3b3655f0@amd.com>
Date: Fri, 16 Oct 2020 14:54:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CADnq5_O=kSbhuBNTjYiMUp8kwgBfU4XUEULAtYEhJz6rE4hyXg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::7) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 18:54:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c865f7c2-847f-4d8c-6f1a-08d87204f7a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2917B60CC2553E3535F85BA0EC030@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhJM9y0fx0LEUA3JUx/7MnLRD+oxh1bOzzw4UkAb29k+v6ullAVaFJ+pofM2/1ai/YiLf8o/8wTdjAC0dRNgtyQPY0r2/5C/AGoeX/5fnf8MQX3jR08Wsd7nOS4i3PCNnjdEZ07Ppqcy1IvXmCsHBO838W0LTx9lOzPY/QTSpVztdPDWEfX2bOdDcmICQRuHouWnV0CUUbG+8uGCX4lU+uhdqPY87bKcS97fsr5g98IdiWRsLv2vKFq7rtugwzQBcMzYK0WYVL0A5h0yPVSov7/xx7PqS0SMRss8ntB6ts/q//hkzNn3aEheCT+OLATabySZ4+qZHp/ozAlUO0xW+3gfqTUEsfPR5dpaxyT9GXOIf7btsTMb3b7SJdXuK3DndjiXg+L4kjeSgrHqz9zlyCwC+/38Rx1GKoBS/BLou7Ja1P1p2tNzPVMiIu8gyJ/pK0CxkNuSyP2jHlX882SALw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(6486002)(16576012)(86362001)(26005)(478600001)(110136005)(8676002)(6636002)(8936002)(54906003)(2906002)(6666004)(66946007)(956004)(66556008)(66476007)(5660300002)(52116002)(186003)(36756003)(31696002)(966005)(16526019)(4001150100001)(53546011)(31686004)(34490700002)(2616005)(316002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nEbMw1AaTyTFaOQYUcy8DD9L0+Xs4xk4daUtdyRLtzGaEhHsT8ZeE88jn90ml3kbf6rc4gC5oLYEAq3I9w8lmhpdpmsQo4Sdh6d/G7s6S9ot4tR4FP8F7eOaZPjOSWcJ+jQAUHQ+nohum82YL2mUokeMUsVC/UhlWLLGM9dCdbB7+q0LNoh4EHNIxp7prF+ve2lnYbm1bUiQ+f7lOFrjM+KAi4xMMjXfdCxW1GfBSigxBjoUqbLXlmXdg0MrVfYJMIxRz+/a25a1oikKya+GkXWP8zViKdwxoOG5zs7+rPo4QLxeilYMTeiX8eS/DyN4MpWQ4RDbzGbFewWncuPrtqqugcuSDOHjLGClDEB++eXmKw3BACSXD6/D+5R/l7hl7vGUPDou52nCH5lGXQynQV9B9UEdHIcIEEl6mBuKn4ti3W1bVR2MxcEY9sgSf5w5r+tZY77V93jTWm2oCePEcvHfM1NQGSDK3D3Tsb4SFFinRNspk0eyxlA3Vq6nQL9TU45w6hKa7q1X3rdPvh39+2lPh3FfeR4D4LUGbG96dt8HCZB6jskgKRAirmbT2Ec2YHgABJn04AAciSbts+y2VHCdP2JLkQhriajxesBJUOBRUVLF7j5JRSAoXzVE5RBlLAeNhwRtnKYv7cVeLwA0xw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c865f7c2-847f-4d8c-6f1a-08d87204f7a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 18:54:53.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMhel9+CCRaVH1JwEpcgi9fxTtN+Lmqk/Edmm62Lduyr/LhjkQraCYi9wIFEqSMMep77tiMQnrDbkYZ06Qj1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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
Cc: xinhui pan <xinhui.pan@amd.com>, "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-15 11:02 p.m., Alex Deucher wrote:
> On Wed, Oct 14, 2020 at 1:25 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>>
>> On connector destruction call drm_dp_mst_topology_mgr_destroy
>> to release resources allocated in drm_dp_mst_topology_mgr_init.
>> Do it only if MST manager was initialized before otherwsie a crash
>> is seen on driver unload/device unplug.
>>
> 
> Not really an mst expert, but this seems to match what i915 and
> nouveau do.  Series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Looks reasonable to me. Untested, however.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a72447d..64799c4 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5170,6 +5170,13 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>>          struct amdgpu_device *adev = drm_to_adev(connector->dev);
>>          struct amdgpu_display_manager *dm = &adev->dm;
>>
>> +       /*
>> +        * Call only if mst_mgr was initialized before since it's not done
>> +        * for all connector types.
>> +        */
>> +       if (aconnector->mst_mgr.dev)
>> +               drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>> +
>>   #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
>>          defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
>>
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
