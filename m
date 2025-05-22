Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7113CC54F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D38014A846;
	Thu, 22 May 2025 04:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qT1MnaFN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B8194367
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOKhp8kVD7nRLaSvOwP6v4pfbGmuid/4L/7MSTP0Bg/P8cADIhlcYwEHHqPoPZ5Lr863QGfkn90Zlv1V0L0c5bkJOUKzJdfxW+GZhhDugmcoCN/84SKdA6JYUIhoUri+0IX5flRJhTE8xpairvRMVZebDMNiZClXoMyPeLhvyyVUeJjo5ysvDqNaMqrtYPwl+1ICDkWvpvdQ9295u80s07iS7lqQ2VkQOBhA3XwHqmjszI69QSqshmTdeMk609vbhBoFr/9uSBzPZCVRQx9WrlnWYp9khEIgqLqkGS2KMC9qqoJCJdPycDcNSkUxZW19Q7N05TsfRCZH5suzXWF9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWEWsU5AXvZ7kRNZiT1jgVTpekr5WwNxAT6UHpezAJs=;
 b=h+joDk9dVksvhSDq9GasZtscXCmGe+Z8xMDIbXDnq76JAjgIRnacgP70nPLbCtWmrqUShOMlZHRKKOdk392/fIbKuWLqV+n4RV7aArZaj/7ayncit5zJaXbL0U/rnA2EfxDvRfDbr+psI0CJf6vcN9iPby45WICNxAFEaS8ClfMDh9hFpnphL0D72ZEHgaU4qlc/Sk9hUpMsqQRM7C6c/DUVk2ZjdkDwnvx2UAhe2u71rHHr2vWA1BprcYXHHgiLiXQrQSjLKWi2byWXNw3BOYal5cDnU3ylor4+PeQE0DmkwVQzCIoRkA4jdzd+WoxUwm8yqSEaN0z4MrKTZ/RKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWEWsU5AXvZ7kRNZiT1jgVTpekr5WwNxAT6UHpezAJs=;
 b=qT1MnaFN1Sr1LrsJI7g8TV2XJnO/K7paDTsc35kknC8vVD63px8foh2dIEIBAJf5ggOZqkSMcUU4tdYP2GXwQZY7QwBb38mZNSO2Cm2Jauee6pMRmWN1ttESmEAAu6umCdef3GJW9uu6Kd4JdDqeoWKt2YBFkWgvURtpChGpq1g=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 22 May
 2025 03:49:55 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 03:49:55 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbyJcs4MJaW6/wr0qotfWV8KGndLPZ+q8AgAGFFACAAT1wgIAAxUUA//98X4CAAY7igA==
Date: Thu, 22 May 2025 03:49:44 +0000
Message-ID: <83898bee-0735-4131-b52f-faf87b7c48cf@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
 <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
 <67fc5bc0-e1a7-4074-ab4e-bd7735b60cd1@amd.com>
 <8b2ea507-403c-471a-a3d4-db23f3d2f096@amd.com>
 <938e4e19-c594-427c-bc1f-73dda305fc44@amd.com>
In-Reply-To: <938e4e19-c594-427c-bc1f-73dda305fc44@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8746.028)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|BN7PPF7F4CD71A4:EE_
x-ms-office365-filtering-correlation-id: a4e60692-cf49-427a-8493-08dd98e3b703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?V9B3OVPMoy7AoPd+7/XY0zPHphJn4nlD7z5qpLbP1/HyIryGf15BsOHpmZ?=
 =?iso-8859-1?Q?Nth3H14BsCF+DTTh/I1a+sUwZtu1mAjehRdog5CVJW3hWGLuBcKifLu/Fm?=
 =?iso-8859-1?Q?xltcV/fZYKeaB00aE3Mz+Xnc0LATGZlgThwgPRykw/ZFGKpnHYpGu3D1ZS?=
 =?iso-8859-1?Q?skFHqKiJ3wQz0/WPyQjk/91XhS0lbynpFDLgptUdw4USg3c+OHoC6HkWjO?=
 =?iso-8859-1?Q?nI7Ua5TFrqYAON1227uG9JB5bpeBrd9BUwY5Ovpc4IdWmNmO5eq3vKr7pL?=
 =?iso-8859-1?Q?Tvc0hS4SC59zywKRCT4BMhORD+UDrvH9uDU8Aw7tlYfnyiUN8y536q1Tf7?=
 =?iso-8859-1?Q?IG/1aLTBPnvRVN3xef4ALiFZEBuTWmEh5XM3x0qVyUFEtlqhYZC5kPWOhR?=
 =?iso-8859-1?Q?LL5RTZUy4MLAdbPhkwnGvGJSaV3DCjU+Q8xQSTP4wEldMOfgMxIvckRMxW?=
 =?iso-8859-1?Q?+U8QrvNtMTHFsA6vgcRjzdrqrJjh3v+ozb+TVk1Bi2O2L275t/d2mR6iSB?=
 =?iso-8859-1?Q?BfwAbIxBbHXOqGyqKgBDDdX3RQZHHai0ccyeSkpi93xsHhMRgejYSuQE+5?=
 =?iso-8859-1?Q?zOgXmzVppbKYYiYtQM3yg2mg6ercSnG08doBQoY1ZCAEmFbsteBE1s6S7V?=
 =?iso-8859-1?Q?HjKRf41iwmGQEs5lC9eAgACwss4dSWR0ycNn7c5Yrvg7SD9XZMo/mF/fc1?=
 =?iso-8859-1?Q?k/dyQHOWaNlozGSir7k75bot9EjcN8H7fi3nl1zBlyMcf607Yi001Tv1mu?=
 =?iso-8859-1?Q?eFv3kYHhWJIa6Y1sNRjjS4SIs7FXlvgK7f1jTEhYRD+mblU/HkxcAo4Acb?=
 =?iso-8859-1?Q?pSNViJn/itJ91Qs3kUEh6IXyAGEkrfe8u69LXheERUTqg9ZRm+NZl/7G2f?=
 =?iso-8859-1?Q?201+aLwzNa0LqhNxiFi5+PlCssdozTf1DRoiXeeYUcJdDYsYHfIcjcDS5a?=
 =?iso-8859-1?Q?1pVrq5i/2OKdHI1K1naHDLYIgQg2wgacdJ02Rjw7Fi0rAaAVfDhpd6IP/7?=
 =?iso-8859-1?Q?OqVtyZ+E8+9Nf+AZBko4HWK/xQW3rJoiBMXSVWhN/TiWwS9Mv0+fl/Zo0Y?=
 =?iso-8859-1?Q?/lvezIaCwLzSEtUxaS6KJ3G1/3YD99aY+HKdJ2oCr5pybh5ymN2usFs95H?=
 =?iso-8859-1?Q?OwzdOc9hm9nzifkZOTS/alkG0zC/qg7Wi75YuR+jkNhi0eZ0KC56wx3Hmy?=
 =?iso-8859-1?Q?dRR1/PSKsJoRyeLWtL1Pcq5qWKa7zbVdoOMWbmUxVBCb763SChcrvTHJg5?=
 =?iso-8859-1?Q?e8ba+ABgq24P6bXw0FZ45zCCx9QxCK9dg5KxyRbD0WWi0kR7bx+8YtS/UC?=
 =?iso-8859-1?Q?brse23hQEu9j1ldN5iv5w9jKGvTRjoS6HdsBc57boL6xH8cMcgnYhtZwNG?=
 =?iso-8859-1?Q?N9tRFNCu3xyE7hHvi2F6J5kQA5s1LXyAsj9kmNbz7tdggerEDjuoN7ISda?=
 =?iso-8859-1?Q?fPcvdsdxrz5pA4MTCRtQAvUQdbe83uM3Xw7ZVtvWiOWe5u/Qb/UoYM2WTJ?=
 =?iso-8859-1?Q?4sapeHua54nQVCyKpiR/i4ckub0kd7dy8kbDCAbcp/CdT4g0e+6G1jCI4O?=
 =?iso-8859-1?Q?U6LOAdI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0wRR2qDU2KXaRFYP63bWsR8prTxZlxpuOHWzBA6q4rplYjqRQm5+bnCZxV?=
 =?iso-8859-1?Q?M4xJc5nVuAgoU54h7CKjlbg7SVElvLW0WuFMMH3o0Te9BijQDtGZhC/wOp?=
 =?iso-8859-1?Q?Sv6p6kYsCFGBJOo3UYRLEvggJkP19DF4XjI80O8a95wND47wpsZrCNBdEa?=
 =?iso-8859-1?Q?OZdg06KrAeQV2tkcIHL2Agzo8plbOo/teFzZHZQdLCBCS0msAJ+slRvk3v?=
 =?iso-8859-1?Q?oJhh8uoYE3feRiBg9DSQaMeN4ufw7TcX6ILruAIO92GQW8FyFgpqbyxDpu?=
 =?iso-8859-1?Q?5L4ykaQMxCE2Xo+KEkWVZ/DaMpcUhhd72522CCBPqXyOdl++o+tXgp5q26?=
 =?iso-8859-1?Q?Vnx4XoeY2+2P/fqthxr9l9XhsFsU3Lu1qrHSvcgkSSuVnDbGXWofxDZGAy?=
 =?iso-8859-1?Q?L4VhR7A57G4P1wWMLWzckYxfqV9jhPxOx7V6P8BtBSS6VYglKNCyBKhuK0?=
 =?iso-8859-1?Q?qME7Cq0k7S3OARmY9CXJyncZABKYfhDRaH2aDZu0Pz9HnWf22JfJU0eCEo?=
 =?iso-8859-1?Q?lI11ukgkg9Qok2XQ6Mex+xTYiu8KM6FxESR+NOc+Ozqxz9K2c0JofXhXBJ?=
 =?iso-8859-1?Q?dpIRXKrEj4smqtkSGYmBzLcd+1wGfkpmuFMxTrneJbOgOfGmIXZxcai7Bb?=
 =?iso-8859-1?Q?X43+yaiqP1iYS14JFE9okyYkLbrNOJZMSRlrEONNYjEMb7ww5mgVmvFgiZ?=
 =?iso-8859-1?Q?Nj5RYqong0hYFq71Ne+JU9eOy2zbnpd+nkWpqqHffzIXF5Myrvj2/f0ofy?=
 =?iso-8859-1?Q?BSuN+zKaLSrT8/mWx63C7bqa1Wk0JsnmL1GQdvOPDe4m0o2Pj+5GIptr1p?=
 =?iso-8859-1?Q?cv7UlMtq9kpvI+WzfCUX1fcNZFcEepCYmLu1GP4TnEgaQyqA2GZ/qKiK3g?=
 =?iso-8859-1?Q?NMujpeQzPirAW88DG3BFDh1SicvJ13Yo/aj4NQ7tStN6CFYBHiwNIBh863?=
 =?iso-8859-1?Q?isO9yH9BM0Cv5Ho+okdB1+G6ctTuzximNh+Ud6FgIkyptOXsfoOklGIhEb?=
 =?iso-8859-1?Q?B4Ghiks5bh5AGWg17ocu+8CmrlqorCg3s0RVZ7H66UW9ZOM+aXR4thK4m4?=
 =?iso-8859-1?Q?FieoNoziRC3S+CWLtTGyHXzt2a9HOjX+pnqaioRWI7CBVqN3fs/drDq9+p?=
 =?iso-8859-1?Q?/+Cf8lfXFF4ZulAsMPKge1/MXLXqZbS6IrqylVWS8WQZTTyxngQ03N08x3?=
 =?iso-8859-1?Q?VPZMCziSkGR8TKpouUQki4ZpVnPvrAevFbKGd7sAvnijTbVdSfvKILpCEt?=
 =?iso-8859-1?Q?qbZpwN9tnBzE4CbfZKC4cxeSegGeV73xYhQPyJvOh84UI/8Y+HH+kc5YVQ?=
 =?iso-8859-1?Q?5xi2WmelwActmo6T1ntadihvbtFAHmKdinZDgc+Nserou6FxvecnHI8zVa?=
 =?iso-8859-1?Q?Xl03eRvrXJo91TFhtlNcyk+aaNaNInOm4hGwmafbXAZwqnpOUkTOo6cs3i?=
 =?iso-8859-1?Q?M6i3SlhwvnUuYHdxfiDd5CQyd15oD/N+3W7IrDSkKrOJmRyqCDBn3x3r2B?=
 =?iso-8859-1?Q?NByTGybP8DbozVgq9SE+T/rG3RodKa796hWMN/wuoqNeyvVkuQlTF/WzMZ?=
 =?iso-8859-1?Q?KDwf9RyXLpd45+lJCcVFPwvbacTMtB1z3p02fUDFWa8uoW6Mk8jVSYPAAr?=
 =?iso-8859-1?Q?LbcxqujiHcybmDfXXA+LPCp4ZBGcsoqj3B?=
Content-Type: multipart/alternative;
 boundary="_000_83898bee07354131b52ffaf87b7c48cfamdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e60692-cf49-427a-8493-08dd98e3b703
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:49:55.1307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlL2vBwDj6qTVCZE+XT9bWROWWfk/keLgUl8Lf63TYGr5L/JXh6VmDqWVtpDE8UI/w+Xy+ODqdZ93Iq1gnMvhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4
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

--_000_83898bee07354131b52ffaf87b7c48cfamdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/21 20:00, Christian K=F6nig wrote:
> On 5/21/25 13:55, Zhang, GuoQing (Sam) wrote:
>> On 2025/5/21 16:06, Christian K=F6nig wrote:
>>> On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:
>>>>>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>>>> +            /* set mc->vram_start to 0 to switch the returned GPU a=
ddress of
>>>>>> +             * amdgpu_bo_create_reserved() from FB aperture to GART=
 aperture.
>>>>>> +             */
>>>>>> +            amdgpu_gmc_vram_location(adev, mc, 0);
>>>>> This function does a lot more than just setting mc->vram_start and mc=
->vram_end.
>>>>>
>>>>> You should probably just update the two setting and not call amdgpu_g=
mc_vram_location() at all.
>>>> I tried only setting mc->vram_start and mc->vram_end. But KMD load wil=
l
>>>> fail with following error logs.
>>>>
>>>> [  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
>>>> 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
>>>> [  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
>>>> 0x0000018000000000 - 0x000001801FFFFFFF
>>>> [  329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M
>>>> [  329.314386] [drm] RAM width 8192bits HBM
>>>> [  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
>>>> kernel bo
>>>> [  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>>>> block <gmc_v9_0> failed -22
>>>> [  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init fail=
ed
>>>>
>>>>
>>>> It seems like setting mc->visible_vram_size and mc->visible_vram_size
>>>> fields are also needed. In this case call amdgpu_gmc_vram_location() i=
s
>>>> better than inline the logic, I think.
>>> Yeah, exactly that is not a good idea.
>>>
>>> The mc->visible_vram_size and mc->real_vram_size should have been initi=
alized by gmc_v9_0_mc_init(). Why didn't that happen?
>>
>> [Sam] visible_vram_size is set to 0x4000000000 (256G) from
>> `pci_resource_len(adev->pdev, 0)` in `gmc_v9_0_mc_init()`.
>> It is set to real_vram_size 0x2fec000000(192G) in
>> amdgpu_gmc_vram_location().
>>
>> Should I update the 3 variables inline and not call
>> amdgpu_gmc_vram_location()?
>>
>>           mc->vram_start =3D 0;
>>           mc->vram_end =3D mc->vram_start + mc->mc_vram_size - 1;
>>           if (mc->real_vram_size < mc->visible_vram_size)
>>               mc->visible_vram_size =3D mc->real_vram_size;
> Yeah that seems to make sense.
>
>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/d=
rm/amd/amdgpu/mmhub_v1_8.c
>>>>>> index 84cde1239ee4..18e80aa78aff 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>>>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdg=
pu_device *adev)
>>>>>>           top &=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>>>>>           top <<=3D 24;
>>>>>>
>>>>>> -    adev->gmc.fb_start =3D base;
>>>>>> -    adev->gmc.fb_end =3D top;
>>>>>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>>>> +            adev->gmc.fb_start =3D base;
>>>>>> +            adev->gmc.fb_end =3D top;
>>>>>> +    }
>>>>> We should probably avoid calling this in the first place.
>>>>>
>>>>> The function gmc_v9_0_vram_gtt_location() should probably be adjusted=
.
>>>> mmhub_v1_8_get_fb_location() is called by the new
>>>> amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location(=
).
>>> Oh, that is probably a bad idea. The function amdgpu_bo_fb_aper_addr() =
should only rely on cached data.
>>
>> [Sam] Can I add new `fb_base` field in `struct amdgpu_gmc` to cache the
>> value of `get_fb_location()`?
> No, please try to avoid that.

OK. so "amdgpu_bo_fb_aper_addr() should only rely on cached data." is
not required and I don't need to change current amdgpu_bo_fb_aper_addr()
implementation, right?


>
>> Using this approach, we don't need to set fb_start and fb_end on resume
>> any more, since the reset of the 2 field is caused by
>> mmhub_v1_8_get_fb_location() calls from amdgpu_bo_fb_aper_addr().
>> Please see the code change below.
> What is wrong with setting fb_start and fb_end on resume?

It works. I have updated the patch in this way.

>>>> mmhub_v1_8_get_fb_location() is supposed to be a query api according t=
o
>>>> its name. having such side effect is very surprising.
>>>>
>>>> Another approach is set the right fb_start and fb_end in the new
>>>> amdgpu_virt_resume(), like updating vram_base_offset.
>>> That is probably better. And skip setting fb_start and fb_end in amdgpu=
_gmc_sysvm_location() for this use case.

setting fb_start and fb_end in amdgpu_gmc_sysvm_location() is needed for
normal KMD load, since amdgpu_virt_resume() is not called on normal KMD
load.

I have sent out v7 patch list. Please take another look. Thank you!

mail titles:
[PATCH v7 0/4] enable xgmi node migration support for hibernate on SRIOV
[PATCH v7 1/4] drm/amdgpu: update xgmi info and vram_base_offset on resume
[PATCH v7 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
[PATCH v7 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
[PATCH v7 4/4] drm/amdgpu: fix fence fallback timer expired error

changes:
- remove pdb0_enabled and add gmc_v9_0_is_pdb0_enabled()
- remove amdgpu_gmc_vram_location() call in amdgpu_gmc_sysvm_location()
- remove check in mmhub_v1_8_get_fb_location() and update
fb_start/fb_end on resume

Regards
Sam


>>>
>>> That was done only because we re-program those registers on bare metal.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Which approach do you prefer? Or any better suggestions? Thank you.
>>>>
>>>>
>>>> Regards
>>>> Sam
>>>>
>>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>           return base;
>>>>>>       }

--_000_83898bee07354131b52ffaf87b7c48cfamdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <0CCC2C27C945AC4CB393389FFD117005@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/21 20:00, Christian K=F6nig wrote:<br>
&gt; On 5/21/25 13:55, Zhang, GuoQing (Sam) wrote:<br>
&gt;&gt; On 2025/5/21 16:06, Christian K=F6nig wrote:<br>
&gt;&gt;&gt; On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_e=
nabled(adev)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* set mc-&gt;vram_start to 0 to switch the returned GPU =
address of<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_bo_create_reserved() from FB aperture to G=
ART aperture.<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, 0);<br>
&gt;&gt;&gt;&gt;&gt; This function does a lot more than just setting mc-&gt=
;vram_start and mc-&gt;vram_end.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; You should probably just update the two setting and no=
t call amdgpu_gmc_vram_location() at all.<br>
&gt;&gt;&gt;&gt; I tried only setting mc-&gt;vram_start and mc-&gt;vram_end=
. But KMD load will<br>
&gt;&gt;&gt;&gt; fail with following error logs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196=
288M<br>
&gt;&gt;&gt;&gt; 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512=
M<br>
&gt;&gt;&gt;&gt; 0x0000018000000000 - 0x000001801FFFFFFF<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=
=3D262144M<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.314386] [drm] RAM width 8192bits HBM<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) fai=
led to allocate<br>
&gt;&gt;&gt;&gt; kernel bo<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.315013] [drm:amdgpu_device_init [amdgpu]] *ERR=
OR* sw_init of IP<br>
&gt;&gt;&gt;&gt; block &lt;gmc_v9_0&gt; failed -22<br>
&gt;&gt;&gt;&gt; [&nbsp; 329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_de=
vice_ip_init failed<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It seems like setting mc-&gt;visible_vram_size and mc-&gt;=
visible_vram_size<br>
&gt;&gt;&gt;&gt; fields are also needed. In this case call amdgpu_gmc_vram_=
location() is<br>
&gt;&gt;&gt;&gt; better than inline the logic, I think.<br>
&gt;&gt;&gt; Yeah, exactly that is not a good idea.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The mc-&gt;visible_vram_size and mc-&gt;real_vram_size should =
have been initialized by gmc_v9_0_mc_init(). Why didn't that happen?<br>
&gt;&gt;<br>
&gt;&gt; [Sam] visible_vram_size is set to 0x4000000000 (256G) from<br>
&gt;&gt; `pci_resource_len(adev-&gt;pdev, 0)` in `gmc_v9_0_mc_init()`.<br>
&gt;&gt; It is set to real_vram_size 0x2fec000000(192G) in<br>
&gt;&gt; amdgpu_gmc_vram_location().<br>
&gt;&gt;<br>
&gt;&gt; Should I update the 3 variables inline and not call<br>
&gt;&gt; amdgpu_gmc_vram_location()?<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram=
_start =3D 0;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram=
_end =3D mc-&gt;vram_start + mc-&gt;mc_vram_size - 1;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mc-&gt;=
real_vram_size &lt; mc-&gt;visible_vram_size)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mc-&gt;visible_vram_size =3D mc-&gt;real_vram_size;<br>
&gt; Yeah that seems to make sense.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8=
.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; index 84cde1239ee4..18e80aa78aff 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_lo=
cation(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
top &amp;=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
top &lt;&lt;=3D 24;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_virt_xgmi_migrate_=
enabled(adev)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; We should probably avoid calling this in the first pla=
ce.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; The function gmc_v9_0_vram_gtt_location() should proba=
bly be adjusted.<br>
&gt;&gt;&gt;&gt; mmhub_v1_8_get_fb_location() is called by the new<br>
&gt;&gt;&gt;&gt; amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_g=
tt_location().<br>
&gt;&gt;&gt; Oh, that is probably a bad idea. The function amdgpu_bo_fb_ape=
r_addr() should only rely on cached data.<br>
&gt;&gt;<br>
&gt;&gt; [Sam] Can I add new `fb_base` field in `struct amdgpu_gmc` to cach=
e the<br>
&gt;&gt; value of `get_fb_location()`?<br>
&gt; No, please try to avoid that.<br>
<br>
OK. so &quot;amdgpu_bo_fb_aper_addr() should only rely on cached data.&quot=
; is <br>
not required and I don't need to change current amdgpu_bo_fb_aper_addr() <b=
r>
implementation, right?<br>
<br>
<br>
&gt;<br>
&gt;&gt; Using this approach, we don't need to set fb_start and fb_end on r=
esume<br>
&gt;&gt; any more, since the reset of the 2 field is caused by<br>
&gt;&gt; mmhub_v1_8_get_fb_location() calls from amdgpu_bo_fb_aper_addr().<=
br>
&gt;&gt; Please see the code change below.<br>
&gt; What is wrong with setting fb_start and fb_end on resume?<br>
<br>
It works. I have updated the patch in this way.<br>
<br>
&gt;&gt;&gt;&gt; mmhub_v1_8_get_fb_location() is supposed to be a query api=
 according to<br>
&gt;&gt;&gt;&gt; its name. having such side effect is very surprising.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Another approach is set the right fb_start and fb_end in t=
he new<br>
&gt;&gt;&gt;&gt; amdgpu_virt_resume(), like updating vram_base_offset.<br>
&gt;&gt;&gt; That is probably better. And skip setting fb_start and fb_end =
in amdgpu_gmc_sysvm_location() for this use case.<br>
<br>
setting fb_start and fb_end in amdgpu_gmc_sysvm_location() is needed for <b=
r>
normal KMD load, since amdgpu_virt_resume() is not called on normal KMD <br=
>
load.<br>
<br>
I have sent out v7 patch list. Please take another look. Thank you!<br>
<br>
mail titles:<br>
[PATCH v7 0/4] enable xgmi node migration support for hibernate on SRIOV<br=
>
[PATCH v7 1/4] drm/amdgpu: update xgmi info and vram_base_offset on resume<=
br>
[PATCH v7 2/4] drm/amdgpu: update GPU addresses for SMU and PSP<br>
[PATCH v7 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV<br>
[PATCH v7 4/4] drm/amdgpu: fix fence fallback timer expired error<br>
<br>
changes:<br>
- remove pdb0_enabled and add gmc_v9_0_is_pdb0_enabled()<br>
- remove amdgpu_gmc_vram_location() call in amdgpu_gmc_sysvm_location()<br>
- remove check in mmhub_v1_8_get_fb_location() and update <br>
fb_start/fb_end on resume<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That was done only because we re-program those registers on ba=
re metal.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Which approach do you prefer? Or any better suggestions? T=
hank you.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; Sam<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return base;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;&nbsp; }<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_83898bee07354131b52ffaf87b7c48cfamdcom_--
