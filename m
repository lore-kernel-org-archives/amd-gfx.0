Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FB606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y+HrLDse
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2E810F418;
	Mon, 16 Nov 2026 19:52:39 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D041410EF65
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M74pWGi87TdaLwBXF3NNNTputHvf8cLW8Oja7pUE+1WJYi0HCZAcg4gN6NKjP4C5ujcwpZk8EEQ3gSo1UcWCLzePsE5YCmoUF2gGEw1HZqkTNDp5hjRWfuUWJs5N/Zqc75bmlmi8jQNUhLMf2E44pWZUNy8UpeAj0sZfLFWF9fPu0FmTUB+O8k5jeojEQrkxaqaImgBUrgGIM8Outot8XPDj4X2gZtLNOSFbC0L1F9nGpyq9rWOFfOM3g3MxcrGQfPTR1lbsrgo4nt03Oc0RduiRTx8mtqst63ruPhd51jI5tv19DLYxDVz6sImb5y5J7xt5cVtzEGZJw0vYjk9mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bx6qgAoyiR5UuLjaD9Zh5/3I+n6f0f8IED75IwvwsQ=;
 b=EuZ3EvDs6AMsHNif4BkwVCcNE04etJiXu5e8BKBd/H1Q0wVwILwYKJnFC24ij7MSmppWh0YqGjQ4QKXqwx2hhmwKkd6u8WBit1yspazWdXWUSNrSOeGWyEQ3pWOLh6TXI3I0rv1Eh8FeLLCfZ5ecNJhUFinRpiW8mg6rcgiDUeS1ss8L1NJ/a5iBaoDU4SqfzlELmNAH65CM8k3V5Z70ZGQU6wXdyVxFozArmipmAeSfO4UuBpqOE9R2oyodMvQrYJYLt64V6v8Y1VmsAEkZ8pAX2eWT6OFzz5k86llaWiktjNkqUCJC9WG7DX5L5++etB0bHB3caVtwhtngCs5fzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bx6qgAoyiR5UuLjaD9Zh5/3I+n6f0f8IED75IwvwsQ=;
 b=Y+HrLDsePpVBHsrusL7okfzNtSawF439H5fZDE5dJqp2gr5uVFwP+bK44CCIqDTrjBuZB7mnc3gMTN8l9o/MdGyO14p6pgwCeXxo/TE2FcopOcOB5oXQLSUsxdJwqtzeKwgZ+aMpYAUw2XYCGgJI7TwfWV2Ut5hRB4X0dF2JWkc=
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:51:37 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 19:51:37 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 126, Issue 418
Thread-Topic: amd-gfx Digest, Vol 126, Issue 418
Thread-Index: AQHdc4a3c7csZIqgo0+TbW4OLQe+c7cxIG7v
Date: Mon, 16 Nov 2026 19:51:36 +0000
Message-ID: <DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2@DSVPR12MB449095.namprd12.prod.outlook.com>
References: <mailman.23963.1794585027.6457.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.23963.1794585027.6457.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T19:51:36.407Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB449095:EE_|IA4PR12MB9833:EE_
x-ms-office365-filtering-correlation-id: 148e6e55-62fa-4fdb-4bb9-08df441b0641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|376014|23010399003|366016|4022899009|1800799024|38070700021|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|4013099003|4053099003|13003099007|8096899003;
x-microsoft-antispam-message-info: nTMIzjJKehGvXMKdCa3op6853xv12zo2CKTe/uYKz2E7ozYfu+2AK8rvOdy4BX/Dj2ddMEHVqIHiZtkkP6MlhBHqo5DhxJpPlR/jci6IWF8035spLydsFH9tHGwRk4c2s8TahMnx7dellgCAUVdOaWPGobD+ny499cPq3+gpuq3n/1CCLsmRWwiDCC3IxVRYAiosKdBNDJj655lA786MaPx8Vo3jUcNVE9+KYOBOJg4vqbCuUNU3me/NqqynfW0e7aARQWe9zSJxN/ql1sK3SA25DU/qKiqGAyucNzfKEDBlixiA4UcIVbgqxzwinmd3tQvx3kZ5CIHG9hNx4Z0OAePbl7MCklD+hABafzxCYLPv6kHCOdwdh7za7z4gAY1FcNhnH0AoyWKvic25nvDlf5EwWvmqA5OtpnI2TAI+H7PE9tJ5zUpgK03NNrxef0+jTkDIg3Hn14RizLnOFi5/3V+Hd0m50kngtfEkIBTrA9g+GC3lFQ987hNYBX2ZeX/38Ek4b7uGEYpOK9PMukFVCo6C0LimCZb17ilfsGFTj72UywejDql+o0NuyebIr6b77MGenvtcMc7F4T18YoATxl1doOVYV6qB95TF45lZexsyIuAEnSPuJhdDjTYqF5DDPb9mXpDn2yyAf1ZQZAgoIoqxH9/0q7QB1bIeQZlMlMA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(376014)(23010399003)(366016)(4022899009)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(4013099003)(4053099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oOpUV+CU3w4jfb2BGv1+4AFNZIDOEXt2SAE8mI/aIyCKW0MjHB4kdb0Osv?=
 =?iso-8859-1?Q?x7j1ZnPuHnchmgAJzxEkU3oHN/2RJzFQXCJxRUj1Z7Bp3aOH1FAsnxLK8y?=
 =?iso-8859-1?Q?LuJrwf/hzFZdkfm4FOilSzErgfbKurTJS4KMg3EDB82/sFc2dmDrb6AWWN?=
 =?iso-8859-1?Q?B3vaq+FqyfmGUsFIekVObd43puuZziyLxMElo4VDWYGzTho6hXwwINZamS?=
 =?iso-8859-1?Q?4QaTaWuZ4vatMu+VvI1+mc6pxqfn6xoi5vNhW3UaAp+VjwZKj4QXRi+wBd?=
 =?iso-8859-1?Q?jTKfvNsTzjefILaiFYUM2upnzYRAXnEt3QEA6kdKWgkAwB+7pvEHRphwQT?=
 =?iso-8859-1?Q?WTm5tL+b/+/bm6DQu3GgDVDoC+CTS6FKv9Z7u9tjPGkJlufEMBxeOJlgTi?=
 =?iso-8859-1?Q?u3enF5OAVKi/GzZdDzCWY7h1SuOZzqEAtEOX2Y/Bxwg1UxJpWe08afI2yf?=
 =?iso-8859-1?Q?AXPK3LqtyKgiQiYSoOgHirMtC/GhjzidBAvwQKQxLXZh6fftrR02yBQQmQ?=
 =?iso-8859-1?Q?4Bfv3MxWGBd0uBh6/KVrej3AqoKEvP95NX+6I1bZVqDW/E3kI853OoB+og?=
 =?iso-8859-1?Q?V7THb0DN4pJxAFO6zOgRVsDqyYGDN4d7tTuTToinsk7oLopvBdjt7jSWtS?=
 =?iso-8859-1?Q?h28o+BQcsR+6kUeFAWY/LHYxq9oBthxSCbpdcVqwZm/lr/c/mcchttvlv1?=
 =?iso-8859-1?Q?5Df1/De12o+j7wvpZNlluOC0TKpRr+L9q+3C96RYMzyqAwJDfjIO1Bq7IG?=
 =?iso-8859-1?Q?EKIUtbOmAK4kND09fEEt+n+5w+TFqCV8AiFSrpjNOk6xKOTsAk5JSR+IDc?=
 =?iso-8859-1?Q?vCWlJLQ+cTZIuenQzUDwVXuRnmkTu0xIKVwTNgQT1RwZUJkiFLmW/mPLQQ?=
 =?iso-8859-1?Q?ExvADsvEtQDSnMkZdlaeD0L+xnMKlzBtPWaRtnpuITaAwcJbWPoPtQsSxZ?=
 =?iso-8859-1?Q?dz5DRO+aQEKftOg8gIEeY4iu2gqkDZm9FqNnFhXM6+cqgKIHxweR2AZBr0?=
 =?iso-8859-1?Q?YEQPQBNSF33AClFDMnnxrqxoWCvp+m9fzwaLA+DZMTvXoXvsjznk/lPOgt?=
 =?iso-8859-1?Q?95hve+YPssYaGB6ZAKoIM8+4+PpRNJxhKWiQOkutM/FngLqt4AVo5TB1aY?=
 =?iso-8859-1?Q?j3aguLgVT3mLCHgadVqgoclLHB1sFcHlpfVm95BAaQS+Nhx5sej2uoiNXM?=
 =?iso-8859-1?Q?NMSwM0q/Ee8r7M+kb8HOiQcg8dE/omql+fuDYv01wbF2nCZ8LL/Ul3xHpd?=
 =?iso-8859-1?Q?BHQbxIFO7ayTwJBfIqrRZksGM11A0uuW9DSk3iwWASOnVPh+WfQGxxM7A1?=
 =?iso-8859-1?Q?HXWUzmK33ra2NCuSOm7vzhT9noWQxy/xEKlMoZmOaF4H69tKwDGu6y8Mh9?=
 =?iso-8859-1?Q?XLMK67xizd4VaaDWXfi46ZQkbCrHTtDXQWWa9LtwRGeMttjKrRSOwv19oa?=
 =?iso-8859-1?Q?UfReU30ioKheD/iGXzRW8KTxXjb2bKmA6IXvcshOSOt+k7qxN8xHLroZh6?=
 =?iso-8859-1?Q?fMZHYZO1OCq39fhT4Ti0XhS7pscD/q9lBpQ1DfsBKABF4NmrjbHMbw+khI?=
 =?iso-8859-1?Q?q98XBjgriSml6lqFs5M8iuMgEmC3gsAIUx5O0pOXJn+47qkfJCe6GuLV8R?=
 =?iso-8859-1?Q?gzmCEUe5l5JAoaJb8IkW/jJyLD+wxXRCD7m0tHxbwN+eu7FC+Y9Ec0XwYR?=
 =?iso-8859-1?Q?ReZLri5aF/8tIK8AeeobjySG3fIAL7YXLsPvVB5OSQFasGnB5uaBL+czz8?=
 =?iso-8859-1?Q?ehshFSltk6UqrV8T2yF8nsj4JCmKUSyu2NoDMxto10GpUw?=
Content-Type: multipart/related;
 boundary="_004_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_";
 type="multipart/alternative"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148e6e55-62fa-4fdb-4bb9-08df441b0641
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 19:51:36.9073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMhBwPl35jV+sDapvKnF5eotP7TASU7IzIbUt6Qw8MnNT/1SQxKeniT1y4Dx2bdimshpFLD7RUbpQIhtKf6VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_
Content-Type: multipart/alternative;
	boundary="_000_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_"

--_000_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



[cid:c2c184ee-b198-41fb-a9b0-d9543831f532]<https://outlook.office.com/bookw=
ithme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlots=
EmailSignature>
Book time to meet with me<https://outlook.office.com/bookwithme/user/5be71e=
58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlotsEmailSignature>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Friday, November 13, 2026 10:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 126, Issue 418

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init
      failure (Mario Limonciello)
   2. [PATCH 1/3] Revert "drm/amdgpu: re-enable SPM updates in the
      the IB path" (Alex Deucher)
   3. [PATCH 2/3] Revert "drm/amdgpu: reemit RLC SPM register in
      ring reemit" (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Fri, 13 Nov 2026 09:47:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: sashiko-reviews@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init
        failure
Message-ID: <4c1fe25b-9e5f-4377-b45d-6b8ee5aae32d@amd.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed



On 11/13/26 08:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/amdgpu: gmc_v*_sw_init() calls amdgpu_bo_fini() with
>    GART/PDB0 BOs pinned
> --
>
> commit 4e2abeed7577cfdf2a67e81d9af414ebfbc361c6
> Author: Mario Limonciello <mario.limonciello@amd.com>
>
> drm/amdgpu: unwind bo_init on GMC sw_init failure
>
> This commit unwinds amdgpu_bo_init() and amdgpu_vm_manager_init() when
> gmc_v*_sw_init() fails after initializing the memory manager across GMC v=
6
> through v12.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v10_0.c
>> index 49f593fe2a876..e59fee3955af0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>>
>>       r =3D gmc_v10_0_gart_init(adev);
>>       if (r)
>> -            return r;
>> +            goto err_bo_fini;
>>
>>       /*
>>        * number of VMs
>> @@ -880,9 +880,15 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>>
>>       r =3D amdgpu_gmc_ras_sw_init(adev);
>>       if (r)
>> -            return r;
>> +            goto err_vm_fini;
>>
>>       return 0;
>> +
>> +err_vm_fini:
>> +    amdgpu_vm_manager_fini(adev);
>> +err_bo_fini:
>> +    amdgpu_bo_fini(adev);
>> +    return r;
>>   }
>
> [Severity: Medium]
> Does jumping to err_vm_fini tear down TTM while adev->gart.bo is still
> pinned?
>
> gmc_v10_0_gart_init() allocates and pins adev->gart.bo in VRAM.  If
> amdgpu_gmc_ras_sw_init() fails, err_vm_fini calls amdgpu_bo_fini() withou=
t
> first freeing the GART table as gmc_v10_0_sw_fini() does.  Because pinned
> BOs cannot be evicted during amdgpu_ttm_fini(), gpu_buddy_fini() and
> drm_mm_takedown() hit warnings and leak the pinned BOs and their backing
> allocations.
>
> The same missing GART cleanup affects the err_vm_fini paths in GMC v7, v8=
,
> v9, v11, and v12.  On GMC v9 and v12, gmc_v*_gart_init() also allocates
> and pins adev->gmc.pdb0_bo when amdgpu_gmc_is_pdb0_enabled() is true, so
> both err_vm_fini and a failure in amdgpu_gmc_pdb0_alloc() within
> gmc_v*_gart_init() reach amdgpu_bo_fini() with pinned BOs still allocated=
.
>

This finding looks correct.  I'll re-spin.



------------------------------

Message: 2
Date: Fri, 13 Nov 2026 10:49:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: re-enable SPM updates in the
        the IB path"
Message-ID: <20261113154954.1865439-1-alexander.deucher@amd.com>
Content-Type: text/plain

This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index 6210edf1937aa..f98a7c6797b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -121,9 +121,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
                        struct dma_fence **f)
 {
         struct amdgpu_device *adev =3D ring->adev;
-       bool emit_spm_needed =3D adev->gfx.rlc.funcs->update_spm_vmid &&
-               (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
-                ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
         struct amdgpu_ib *ib;
         struct dma_fence *tmp =3D NULL;
         struct amdgpu_fence *af;
@@ -212,10 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
         if (need_pipe_sync)
                 amdgpu_ring_emit_pipeline_sync(ring);

-       if (emit_spm_needed)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
-                                                    adev->vm_manager.spm_v=
mid);
-
         if (emit_gds_needed)
                 amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base=
,
                                             job->gds_size, job->gws_base,
--
2.56.0



------------------------------

Message: 3
Date: Fri, 13 Nov 2026 10:49:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: reemit RLC SPM register in
        ring reemit"
Message-ID: <20261113154954.1865439-2-alexander.deucher@amd.com>
Content-Type: text/plain

This reverts commit 8a4dfdc0d2adfc362ec310ff70526e79ff8377b6.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 324d25c77897a..c3f56253d3b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -715,9 +715,6 @@ void amdgpu_fence_driver_force_completion(struct amdgpu=
_ring *ring,
 void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
                                              struct amdgpu_fence *guilty_f=
ence)
 {
-       bool emit_spm_needed =3D ring->adev->gfx.rlc.funcs->update_spm_vmid=
 &&
-               (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
-                ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
         struct dma_fence *unprocessed;
         struct dma_fence __rcu **ptr;
         struct amdgpu_fence *fence;
@@ -749,9 +746,6 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amd=
gpu_ring *ring,
         }
         ring->reemit =3D true;
         amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
-       if (emit_spm_needed)
-               ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring=
->xcc_id,
-                                                          ring->adev->vm_m=
anager.spm_vmid);
         spin_lock_irqsave(&ring->fence_drv.lock, flags);
         do {
                 last_seq++;
--
2.56.0



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 126, Issue 418
*****************************************

--_000_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" data-signature-name=3D"Book =
time to meet with me">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<table id=3D"pbpsiglinktable">
<tbody>
<tr>
<td>
<div class=3D"elementToProof"><a href=3D"https://outlook.office.com/bookwit=
hme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&amp;ep=3DowaSlo=
tsEmailSignature" id=3D"OWA3bccc1b1-7947-0c20-e47f-a4a0a1358719" class=3D"O=
WAAutoLink"><img size=3D"528" data-outlook-trace=3D"F:1|T:1" src=3D"cid:c2c=
184ee-b198-41fb-a9b0-d9543831f532"></a></div>
</td>
<td></td>
<td>
<div class=3D"elementToProof" style=3D"color: rgb(0, 120, 212);"><a href=3D=
"https://outlook.office.com/bookwithme/user/5be71e58d07c492d97048217b901df8=
e@amd.com?anonymous&amp;ep=3DowaSlotsEmailSignature" id=3D"OWAa13f3983-e23f=
-f78e-7734-6ae90dda7152" class=3D"OWAAutoLink" style=3D"color: rgb(0, 120, =
212); text-decoration: none;">Book
 time to meet with me</a></div>
</td>
<td></td>
</tr>
</tbody>
</table>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behal=
f of amd-gfx-request@lists.freedesktop.org &lt;amd-gfx-request@lists.freede=
sktop.org&gt;<br>
<b>Sent:</b> Friday, November 13, 2026 10:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 126, Issue 418</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Send amd-gfx mailing list submissions to<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx" id=3D"OWAbd03437f-c359-d22d-8378-53e5c19=
a9b5c" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; failure (Mario Limonciello)<br>
&nbsp;&nbsp; 2. [PATCH 1/3] Revert &quot;drm/amdgpu: re-enable SPM updates =
in the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the IB path&quot; (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 2/3] Revert &quot;drm/amdgpu: reemit RLC SPM registe=
r in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring reemit&quot; (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Fri, 13 Nov 2026 09:47:13 -0600<br>
From: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
To: sashiko-reviews@lists.linux.dev<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH 2/3] drm/amdgpu: unwind bo_init on GMC sw_init<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; failure<br>
Message-ID: &lt;4c1fe25b-9e5f-4377-b45d-6b8ee5aae32d@amd.com&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
<br>
<br>
On 11/13/26 08:56, sashiko-bot@kernel.org wrote:<br>
&gt; Thank you for your contribution! Sashiko AI review found 1 potential<b=
r>
&gt; issue to consider:<br>
&gt; - [Medium] drm/amdgpu: gmc_v*_sw_init() calls amdgpu_bo_fini() with<br=
>
&gt;&nbsp;&nbsp;&nbsp; GART/PDB0 BOs pinned<br>
&gt; --<br>
&gt;<br>
&gt; commit 4e2abeed7577cfdf2a67e81d9af414ebfbc361c6<br>
&gt; Author: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
&gt;<br>
&gt; drm/amdgpu: unwind bo_init on GMC sw_init failure<br>
&gt;<br>
&gt; This commit unwinds amdgpu_bo_init() and amdgpu_vm_manager_init() when=
<br>
&gt; gmc_v*_sw_init() fails after initializing the memory manager across GM=
C v6<br>
&gt; through v12.<br>
&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/=
drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt; index 49f593fe2a876..e59fee3955af0 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt; @@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_=
block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gmc_v10_0_gart_init(adev=
);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; goto err_bo_fini;<br>
&gt;&gt;&nbsp;&nbsp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * number of VMs<br>
&gt;&gt; @@ -880,9 +880,15 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_ras_sw_init(a=
dev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return r;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; goto err_vm_fini;<br>
&gt;&gt;&nbsp;&nbsp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +err_vm_fini:<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; amdgpu_vm_manager_fini(adev);<br>
&gt;&gt; +err_bo_fini:<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; amdgpu_bo_fini(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; [Severity: Medium]<br>
&gt; Does jumping to err_vm_fini tear down TTM while adev-&gt;gart.bo is st=
ill<br>
&gt; pinned?<br>
&gt;<br>
&gt; gmc_v10_0_gart_init() allocates and pins adev-&gt;gart.bo in VRAM.&nbs=
p; If<br>
&gt; amdgpu_gmc_ras_sw_init() fails, err_vm_fini calls amdgpu_bo_fini() wit=
hout<br>
&gt; first freeing the GART table as gmc_v10_0_sw_fini() does.&nbsp; Becaus=
e pinned<br>
&gt; BOs cannot be evicted during amdgpu_ttm_fini(), gpu_buddy_fini() and<b=
r>
&gt; drm_mm_takedown() hit warnings and leak the pinned BOs and their backi=
ng<br>
&gt; allocations.<br>
&gt;<br>
&gt; The same missing GART cleanup affects the err_vm_fini paths in GMC v7,=
 v8,<br>
&gt; v9, v11, and v12.&nbsp; On GMC v9 and v12, gmc_v*_gart_init() also all=
ocates<br>
&gt; and pins adev-&gt;gmc.pdb0_bo when amdgpu_gmc_is_pdb0_enabled() is tru=
e, so<br>
&gt; both err_vm_fini and a failure in amdgpu_gmc_pdb0_alloc() within<br>
&gt; gmc_v*_gart_init() reach amdgpu_bo_fini() with pinned BOs still alloca=
ted.<br>
&gt;<br>
<br>
This finding looks correct.&nbsp; I'll re-spin.<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Fri, 13 Nov 2026 10:49:52 -0500<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 1/3] Revert &quot;drm/amdgpu: re-enable SPM updates in the<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the IB path&quot;<br>
Message-ID: &lt;20261113154954.1865439-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.<br>
<br>
This causes flakiness in gfx11 CI tests.&nbsp; Revert.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 -------<br>
&nbsp;1 file changed, 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c<br>
index 6210edf1937aa..f98a7c6797b3c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
@@ -121,9 +121,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_=
fence **f)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool emit_spm_needed =3D adev-&gt;gfx=
.rlc.funcs-&gt;update_spm_vmid &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *tmp =3D =
NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fence *af;<b=
r>
@@ -212,10 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_pipe_sync)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_pipeline_sync(ring);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (emit_spm_needed)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, ring-&gt;xcc_id=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;vm_manager.spm_vmid);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (emit_gds_needed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_gds_switch(ring, job-&gt;vmid, job-&=
gt;gds_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;gds_size, job-&gt;gws_base,=
<br>
--<br>
2.56.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Fri, 13 Nov 2026 10:49:53 -0500<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 2/3] Revert &quot;drm/amdgpu: reemit RLC SPM register in<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring reemit&quot;<br>
Message-ID: &lt;20261113154954.1865439-2-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
This reverts commit 8a4dfdc0d2adfc362ec310ff70526e79ff8377b6.<br>
<br>
This causes flakiness in gfx11 CI tests.&nbsp; Revert.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div style=3D"font-size: 11pt;"><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ------<br>
&nbsp;1 file changed, 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c<br>
index 324d25c77897a..c3f56253d3b87 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
@@ -715,9 +715,6 @@ void amdgpu_fence_driver_force_completion(struct amdgpu=
_ring *ring,<br>
&nbsp;void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fence *guilty_f=
ence)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool emit_spm_needed =3D ring-&gt;ade=
v-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *unproces=
sed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence __rcu **p=
tr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fence *fence=
;<br>
@@ -749,9 +746,6 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amd=
gpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;reemit =3D true;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(ring, ri=
ng-&gt;ring_backup_entries_to_copy);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (emit_spm_needed)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(ring-&gt;ade=
v, ring-&gt;xcc_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;adev-&gt;vm_manager.sp=
m_vmid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;rin=
g-&gt;fence_drv.lock, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; last_seq++;<br>
--<br>
2.56.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"OW=
Aad1a8fcb-0d44-cef0-9d38-8e4a7b13001d" class=3D"OWAAutoLink" data-auth=3D"N=
otApplicable">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br=
>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 126, Issue 418<br>
*****************************************</div>
</body>
</html>

--_000_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_--

--_004_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=528;
	creation-date="Mon, 16 Nov 2026 19:50:33 GMT";
	modification-date="Mon, 16 Nov 2026 19:50:33 GMT"
Content-ID: <c2c184ee-b198-41fb-a9b0-d9543831f532>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAcpJREFUOE9j
ZAABr6aJDHqhuQwMDIxgPrHg19d3DLP91Bk+P3sD08IIN2x1hjPDy7NXiDWL4T8nM0NA33wGWRMP
hg5NJgYGhv8gvYwMFdf/MYAMu3twP9GGISssv/qLYVdzMsP5FYthBv5nmO2pyfDzzVuyDEw/eJ3h
xNyJDEenNSMMJMskJE2Hp9YxHJ2CZOBUM1GGz5/hAUuS+UVnXjOcXDCJygbOm4TqZUpcGDJjJcPz
S1eoYyAvrzDD58/vGRgY/iHSYcX1/wykupBXWpghe89reEbY0RjNcGHFMkQsk2pgwYkXDBz84iiR
16EJzmWghE26C8uv/mZgZGJBM5AZ5HXyDPRo7GMwCCuEG/jj40uGCRYS5LsQpNM6q4TBOLqE4emF
gwxrs8NRI2WynSTD19cvSErQOBQzMhSdecvw8vophqWxngQNBCWTrBMvMMIPpnF7dQQjA6+UCEP2
3tcM//7+Zvjx8QNOQydZizFk7bvNwCepgs9iWIHKyGAYEcPALaQEUQwq3mBplQmi5siUBoa0bRcZ
hBT18Bj4n7QSWlhGmiF19xOcBh6aVEyagSCTQEEUNf8Ag6CcFjyn/Pz8hmF9cQjDg8MHAaiKxp0e
iZJ4AAAAAElFTkSuQmCC

--_004_DSVPR12MB4490952D85BFEFA6BDA7E2F1E5817C2DSVPR12MB449095_--
