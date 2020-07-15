Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31951C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 14:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025C22064B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 14:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cViSMUJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025C22064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BBB6EB69;
	Wed, 15 Jul 2020 14:24:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3FC6EB69
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 14:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeVSJry59GxEOcVnrRqFfrmQgyMW1HU+VI2OZIzpxcQ/baZQ7rN5NdYgVg4vnTZs/fVNDxFlQEVDRROE72gdvZbH/+hD2h4OFDxh9ACKF6cjUKKIURFyn2CIbTncf1iu2bOUH9SbafuXiDJvmo/J2QnCL6JsYluHErUk9OPW1h6XC355Xdl9WXmiTAHyuCeppppOgwWIa/7SyKNWsGfN45BYvMt2VPZt0erXVIhQPS8W+LJP5MA/KC9bF4mFp9aMSrzwyEuVberSDgj6DQI+/tXOOVsaqifQLLNwX8OxD+3zXSxVSmIEll4x9YqY2Pky9sha1XnsE/J0SPS+eUVNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr5NmCogblQyQjiJ2ykc/GVxicdyUG2Bv9CTIdSGcbo=;
 b=STUtuQ1IquyGf//lmLzIR8hTvLl2rjwPX09p42KcQX3NlZbb0vlMDT1eDSmpfkSsEcFbYpLx4xNM4V5TDdfhYCrJk7/R37BVzAMtwA6FOaWWTTWlgy8IBmECApX6YbPJrD7demN3yEp2i+rPqCTyNpLGctrOrr7nho/Hg86YJXSg1Y4jpFdjFhsqi17AhwTKHkgju7Av4WhJqvwxSPl1dVsv4Ko6so/HPbbyc3tfx1Dq2qQ2V2MrmqHkQkJ9pyAe+TsO5/QqhD2fEFkgaketV7a6oeQ0ChLDrWmbvQ+zmY+yg1k1VZ+bwzJpu80LLNXOgwzkdo6AL5BdhZD7uaKVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr5NmCogblQyQjiJ2ykc/GVxicdyUG2Bv9CTIdSGcbo=;
 b=cViSMUJmiK6nn5UkoDv/Xx6sTKPFCcfmRhxCpsoi5E+WOXzeWk8HRaYo0fmLKaxYK7RXC5hbTz5snmC1GgtZIIyRWMYZ8Fa54C/PrzTXEN4/amrRNJGn0CFwGRDhNiSnN46itmv5RFoysXOCL8VlyWdorUDO9iMws7MsdC1W2OY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 14:24:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 14:24:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Failed to find memory space for buffer eviction
Thread-Topic: Failed to find memory space for buffer eviction
Thread-Index: AQHWWXfmvrz9oebVwkmZIiUAjyuXEqkGvqiAgAEzjgCAAG9ggIAAUmpP
Date: Wed, 15 Jul 2020 14:24:47 +0000
Message-ID: <MN2PR12MB4488ECEC85B60DAB3CBC33EBF77E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <9f1607ce-3f40-41f5-662f-501434625773@amd.com>
 <b9d9f58c-fdcb-1708-b19c-9da492e9d917@amd.com>
 <e70417e0-82ae-2f9c-87a7-6e28a23ed6a0@amd.com>,
 <3ad7692a-905f-c2e9-c93e-7f407a05204d@gmail.com>
In-Reply-To: <3ad7692a-905f-c2e9-c93e-7f407a05204d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-15T14:24:46.677Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.190.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbb115aa-d437-4c57-0575-08d828cad3b2
x-ms-traffictypediagnostic: BL0PR12MB2436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24368556CA9011B5FDC49378F77E0@BL0PR12MB2436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOik4EMWDd4MwXps+VguuKcbDBTsSCoumJd78296McHiZ0rELi96JIe4H/aIyFj+O2mtGos5szble1MiKQj/PiM0HdK26XoYEWpV394VarUyO4VwQJYa5L3hCq4ryYQ4R5jOFkxGm4hWKozBqOwER0MJzasPEKw02181DllEHZjEtq4yktBxfGvyeh6j7rdbcL0VqqLP6uCr9EG4GrxSkj7e5SE8YX2WTAVqU0N4NXTdTAhAyRQB7Na4CnoeWRpcpHNVprGoUjNRz2tVFcA8IDh1Plc6wb1sx69GXyNKsPdnNSqOBXnBKBasGcDhF3C0aablxIxWZd7LSr/4X81rmvVIME6H+Fz87Crgz7CV/S75yvdIJBOIDhUzcx3dFWICrJh5yF00SCCt5aJDLWsXHir+pTjSa0qKxpuTbekROOU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(8936002)(55016002)(966005)(66476007)(66556008)(64756008)(9686003)(83380400001)(33656002)(71200400001)(7696005)(316002)(86362001)(66446008)(110136005)(52536014)(478600001)(26005)(2906002)(8676002)(53546011)(166002)(5660300002)(66574015)(45080400002)(19627405001)(6506007)(76116006)(66946007)(186003)(37363001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EdRuqczneZB9oopKJE7VExojAijOvgxXhBJ99pZ7B+Ii2l9qBBx9yz7O1tmxNpUOyXxEfKzw7XvbR/jPbtgrvQnsdiUN1BHxa7mfeWaZbHHbGlnT0cWWjcMlqvcl5uvOHaSvDf2H4ms21Rj41SPPGMP804PmvI0uQDnFThYxeSWSjiCF9sAcxRb4vIQw48cRG9weiHP+w8rXNd3Oq88tay2pluiRJQKcCaLoOcPAW0mXWk6Wpa378q2PY3bo57JqMROKf0kkEw+qKAhzSNzAE8IZaA1ZiylM4J8MoR6OrFonfiYtbA/NTs7gRX3Je9nT71DTUZNnCJUtiSwgpK0I0sLc1P+YQIHmcwGug5oO/U81y8XG8djVR7vVnsCb/gi6GbKcFvz1/h7LPUU3FKaQRrEDjptZiJ2kjtUDLSwm+GwelR5q5G9BsXdagUeQVbqqMzyPXhKBETtFLsmJKVJmrY5Nm9U99W901XXbi93qCvP2+shYTz59c6dxww+JsfbH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb115aa-d437-4c57-0575-08d828cad3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 14:24:47.2053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgxeOqiTN0pnZ4evHCclOStvs5OUhSO879OrWLbR8Ssa+jZMuGxenWtyVo6N4AwuUgRR9EBYBnF4SwTF4ehPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Content-Type: multipart/mixed; boundary="===============1601571711=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1601571711==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488ECEC85B60DAB3CBC33EBF77E0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488ECEC85B60DAB3CBC33EBF77E0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Maybe we should re-test the problematic piglit test and if it's no longer a=
n issue, revert:

commit 24562523688bebc7ec17a88271b4e8c3fc337b74
Author: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date:   Fri Dec 15 12:09:16 2017 -0500

    Revert "drm/amd/amdgpu: set gtt size according to system memory size on=
ly"

    This reverts commit ba851eed895c76be0eb4260bdbeb7e26f9ccfaa2.
    With that change piglit max size tests (running with -t max.*size) are =
causing
    OOM and hard hang on my CZ with 1GB RAM.

    Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Roger He <Hongbo.He@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, July 15, 2020 5:28 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Failed to find memory space for buffer eviction

Am 15.07.20 um 04:49 schrieb Felix Kuehling:
> Am 2020-07-14 um 4:28 a.m. schrieb Christian K=F6nig:
>> Hi Felix,
>>
>> yes I already stumbled over this as well quite recently.
>>
>> See the following patch which I pushed to drm-misc-next just yesterday:
>>
>> commit e04be2310b5eac683ec03b096c0e22c4c2e23593
>> Author: Christian K=F6nig <christian.koenig@amd.com>
>> Date:   Mon Jul 6 17:32:55 2020 +0200
>>
>>      drm/ttm: further cleanup ttm_mem_reg handling
>>
>>      Stop touching the backend private pointer alltogether and
>>      make sure we never put the same mem twice by.
>>
>>      Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
>>      Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>
>>      Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F375613%2F&amp;data=3D02%7C01%7Ca=
lexander.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;sdata=3DzilZiBrs%2FV=
rzhZuolVzhLSO2kIBDugp16HT58G7tX8w%3D&amp;reserved=3D0
>>
>>
>> But this shouldn't have been problematic since we used a dummy value
>> for mem->mm_node in this case.
> Hmm, yeah, I was reading the code wrong. It's possible that I was really
> just out of GTT space. But see below.

It looks like it yes.

>> What could be problematic and result is an overrun is that TTM was
>> buggy and called put_node twice for the same memory.
>>
>> So I've seen that the code needs fixing as well, but I'm not 100% sure
>> how you ran into your problem.
> This is in the KFD eviction test, which deliberately overcommits VRAM in
> order to trigger lots of evictions. It will use some GTT space while BOs
> are evicted. But shouldn't it move them further out of GTT and into
> SYSTEM to free up GTT space?

Yes, exactly that should happen.

But for some reason it couldn't find a candidate to evict and the 14371
pages left are just a bit to small for the buffer.

Regards,
Christian.

> Your change "further cleanup ttm_mem_reg handling" removes a
> mem->mm_node =3D NULL in ttm_bo_handle_move_mem in exactly the case where
> a BO is moved from GTT to SYSTEM. I think that leads to a later put_node
> call not happening or amdgpu_gtt_mgr_del returning before incrementing
> mgr->available.
>
> I can try if cherry-picking your two fixes will help with the eviction te=
st.
>
> Regards,
>    Felix
>
>
>> Regards,
>> Christian.
>>
>> Am 14.07.20 um 02:44 schrieb Felix Kuehling:
>>> I'm running into this problem with the KFD EvictionTest. The log snippe=
t
>>> below looks like it ran out of GTT space for the eviction of a 64MB
>>> buffer. But then it dumps the used and free space and shows plenty of
>>> free space.
>>>
>>> As I understand it, the per-page breakdown of used and free space shown
>>> by TTM is the GART space. So it's not very meaningful.
>>>
>>> What matters more is the GTT space managed by amdgpu_gtt_mgr.c. And
>>> that's where the problem is. It keeps track of available GTT space with
>>> an atomic counter in amdgpu_gtt_mgr.available. It gets decremented in
>>> amdgpu_gtt_mgr_new and incremented in amdgpu_gtt_mgr_del. The trouble
>>> is, that TTM doesn't call the latter for ttm_mem_regs that don't have a=
n
>>> mm_node:
>>>
>>>> void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct ttm_mem_reg
>>>> *mem)
>>>> {
>>>>           struct ttm_mem_type_manager *man =3D
>>>> &bo->bdev->man[mem->mem_type];
>>>>
>>>>           if (mem->mm_node)
>>>>                   (*man->func->put_node)(man, mem);
>>>> }
>>> GTT BOs that don't have GART space allocated, don't hate an mm_node. So
>>> the amdgpu_gtt_mgr.available counter doesn't get incremented when an
>>> unmapped GTT BO is freed, and eventually runs out of space.
>>>
>>> Now I know what the problem is, but I don't know how to fix it. Maybe a
>>> dummy-mm_node for unmapped GTT BOs, to trick TTM into calling our
>>> put_node callback? Or a change in TTM to call put_node unconditionally?
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>> [  360.082552] [TTM] Failed to find memory space for buffer
>>> 0x00000000264c823c eviction
>>> [  360.090331] [TTM]  No space for 00000000264c823c (16384 pages,
>>> 65536K, 64M)
>>> [  360.090334] [TTM]    placement[0]=3D0x00010002 (1)
>>> [  360.090336] [TTM]      has_type: 1
>>> [  360.090337] [TTM]      use_type: 1
>>> [  360.090339] [TTM]      flags: 0x0000000A
>>> [  360.090341] [TTM]      gpu_offset: 0xFF00000000
>>> [  360.090342] [TTM]      size: 1048576
>>> [  360.090344] [TTM]      available_caching: 0x00070000
>>> [  360.090346] [TTM]      default_caching: 0x00010000
>>> [  360.090349] [TTM]  0x0000000000000400-0x0000000000000402: 2: used
>>> [  360.090352] [TTM]  0x0000000000000402-0x0000000000000404: 2: used
>>> [  360.090354] [TTM]  0x0000000000000404-0x0000000000000406: 2: used
>>> [  360.090355] [TTM]  0x0000000000000406-0x0000000000000408: 2: used
>>> [  360.090357] [TTM]  0x0000000000000408-0x000000000000040a: 2: used
>>> [  360.090359] [TTM]  0x000000000000040a-0x000000000000040c: 2: used
>>> [  360.090361] [TTM]  0x000000000000040c-0x000000000000040e: 2: used
>>> [  360.090363] [TTM]  0x000000000000040e-0x0000000000000410: 2: used
>>> [  360.090365] [TTM]  0x0000000000000410-0x0000000000000412: 2: used
>>> [  360.090367] [TTM]  0x0000000000000412-0x0000000000000414: 2: used
>>> [  360.090368] [TTM]  0x0000000000000414-0x0000000000000415: 1: used
>>> [  360.090370] [TTM]  0x0000000000000415-0x0000000000000515: 256: used
>>> [  360.090372] [TTM]  0x0000000000000515-0x0000000000000516: 1: used
>>> [  360.090374] [TTM]  0x0000000000000516-0x0000000000000517: 1: used
>>> [  360.090376] [TTM]  0x0000000000000517-0x0000000000000518: 1: used
>>> [  360.090378] [TTM]  0x0000000000000518-0x0000000000000519: 1: used
>>> [  360.090379] [TTM]  0x0000000000000519-0x000000000000051a: 1: used
>>> [  360.090381] [TTM]  0x000000000000051a-0x000000000000051b: 1: used
>>> [  360.090383] [TTM]  0x000000000000051b-0x000000000000051c: 1: used
>>> [  360.090385] [TTM]  0x000000000000051c-0x000000000000051d: 1: used
>>> [  360.090387] [TTM]  0x000000000000051d-0x000000000000051f: 2: used
>>> [  360.090389] [TTM]  0x000000000000051f-0x0000000000000521: 2: used
>>> [  360.090391] [TTM]  0x0000000000000521-0x0000000000000522: 1: used
>>> [  360.090392] [TTM]  0x0000000000000522-0x0000000000000523: 1: used
>>> [  360.090394] [TTM]  0x0000000000000523-0x0000000000000524: 1: used
>>> [  360.090396] [TTM]  0x0000000000000524-0x0000000000000525: 1: used
>>> [  360.090398] [TTM]  0x0000000000000525-0x0000000000000625: 256: used
>>> [  360.090400] [TTM]  0x0000000000000625-0x0000000000000725: 256: used
>>> [  360.090402] [TTM]  0x0000000000000725-0x0000000000000727: 2: used
>>> [  360.090404] [TTM]  0x0000000000000727-0x00000000000007c0: 153: used
>>> [  360.090406] [TTM]  0x00000000000007c0-0x0000000000000b8a: 970: used
>>> [  360.090407] [TTM]  0x0000000000000b8a-0x0000000000000b8b: 1: used
>>> [  360.090409] [TTM]  0x0000000000000b8b-0x0000000000000bcb: 64: used
>>> [  360.090411] [TTM]  0x0000000000000bcb-0x0000000000000bcd: 2: used
>>> [  360.090413] [TTM]  0x0000000000000bcd-0x0000000000040000: 259123:
>>> free
>>> [  360.090415] [TTM]  total: 261120, used 1997 free 259123
>>> [  360.090417] [TTM]  man size:1048576 pages, gtt available:14371 pages=
,
>>> usage:4039MB
>>>
>>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;sdata=3DLVRisNun0DYM%2F5d=
LthnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637304021017509156&amp;sdata=3DLVRisNun0DYM%2F5dLt=
hnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;reserved=3D0

--_000_MN2PR12MB4488ECEC85B60DAB3CBC33EBF77E0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Maybe we should re-test the problematic piglit test and if it's no longer a=
n issue, revert:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>commit 24562523688bebc7ec17a88271b4e8c3fc337b74<br>
</span>
<div>Author: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
</div>
<div>Date: &nbsp; Fri Dec 15 12:09:16 2017 -0500<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; Revert &quot;drm/amd/amdgpu: set gtt size according to s=
ystem memory size only&quot;<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div>&nbsp; &nbsp; This reverts commit ba851eed895c76be0eb4260bdbeb7e26f9cc=
faa2.<br>
</div>
<div>&nbsp; &nbsp; With that change piglit max size tests (running with -t =
max.*size) are causing<br>
</div>
<div>&nbsp; &nbsp; OOM and hard hang on my CZ with 1GB RAM.<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@a=
md.com&gt;<br>
</div>
<div>&nbsp; &nbsp; Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;=
<br>
</div>
<div>&nbsp; &nbsp; Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
</div>
<div>&nbsp; &nbsp; Reviewed-by: Roger He &lt;Hongbo.He@amd.com&gt;<br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.co=
m&gt;<br>
</div>
<span></span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2020 5:28 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesk=
top.org&gt;<br>
<b>Subject:</b> Re: Failed to find memory space for buffer eviction</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 15.07.20 um 04:49 schrieb Felix Kuehling:<br>
&gt; Am 2020-07-14 um 4:28 a.m. schrieb Christian K=F6nig:<br>
&gt;&gt; Hi Felix,<br>
&gt;&gt;<br>
&gt;&gt; yes I already stumbled over this as well quite recently.<br>
&gt;&gt;<br>
&gt;&gt; See the following patch which I pushed to drm-misc-next just yeste=
rday:<br>
&gt;&gt;<br>
&gt;&gt; commit e04be2310b5eac683ec03b096c0e22c4c2e23593<br>
&gt;&gt; Author: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt;&gt; Date:&nbsp;&nbsp; Mon Jul 6 17:32:55 2020 &#43;0200<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; drm/ttm: further cleanup ttm_mem_reg hand=
ling<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; Stop touching the backend private pointer=
 alltogether and<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; make sure we never put the same mem twice=
 by.<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; Signed-off-by: Christian K=F6nig &lt;chri=
stian.koenig@amd.com&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; Reviewed-by: Madhav Chauhan &lt;madhav.ch=
auhan@amd.com&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; Link: <a href=3D"https://nam11.safelinks.=
protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwork.freedesktop.org%2Fpat=
ch%2F375613%2F&amp;amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7Ce1919=
2b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
7304021017509156&amp;amp;sdata=3DzilZiBrs%2FVrzhZuolVzhLSO2kIBDugp16HT58G7t=
X8w%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fpatch%2F375613%2F&amp;amp;data=3D02%7C01%7Calexander.d=
eucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637304021017509156&amp;amp;sdata=3DzilZiBrs%2FVrzhZuo=
lVzhLSO2kIBDugp16HT58G7tX8w%3D&amp;amp;reserved=3D0</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; But this shouldn't have been problematic since we used a dummy val=
ue<br>
&gt;&gt; for mem-&gt;mm_node in this case.<br>
&gt; Hmm, yeah, I was reading the code wrong. It's possible that I was real=
ly<br>
&gt; just out of GTT space. But see below.<br>
<br>
It looks like it yes.<br>
<br>
&gt;&gt; What could be problematic and result is an overrun is that TTM was=
<br>
&gt;&gt; buggy and called put_node twice for the same memory.<br>
&gt;&gt;<br>
&gt;&gt; So I've seen that the code needs fixing as well, but I'm not 100% =
sure<br>
&gt;&gt; how you ran into your problem.<br>
&gt; This is in the KFD eviction test, which deliberately overcommits VRAM =
in<br>
&gt; order to trigger lots of evictions. It will use some GTT space while B=
Os<br>
&gt; are evicted. But shouldn't it move them further out of GTT and into<br=
>
&gt; SYSTEM to free up GTT space?<br>
<br>
Yes, exactly that should happen.<br>
<br>
But for some reason it couldn't find a candidate to evict and the 14371 <br=
>
pages left are just a bit to small for the buffer.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; Your change &quot;further cleanup ttm_mem_reg handling&quot; removes a=
<br>
&gt; mem-&gt;mm_node =3D NULL in ttm_bo_handle_move_mem in exactly the case=
 where<br>
&gt; a BO is moved from GTT to SYSTEM. I think that leads to a later put_no=
de<br>
&gt; call not happening or amdgpu_gtt_mgr_del returning before incrementing=
<br>
&gt; mgr-&gt;available.<br>
&gt;<br>
&gt; I can try if cherry-picking your two fixes will help with the eviction=
 test.<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp; &nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 14.07.20 um 02:44 schrieb Felix Kuehling:<br>
&gt;&gt;&gt; I'm running into this problem with the KFD EvictionTest. The l=
og snippet<br>
&gt;&gt;&gt; below looks like it ran out of GTT space for the eviction of a=
 64MB<br>
&gt;&gt;&gt; buffer. But then it dumps the used and free space and shows pl=
enty of<br>
&gt;&gt;&gt; free space.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; As I understand it, the per-page breakdown of used and free sp=
ace shown<br>
&gt;&gt;&gt; by TTM is the GART space. So it's not very meaningful.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; What matters more is the GTT space managed by amdgpu_gtt_mgr.c=
. And<br>
&gt;&gt;&gt; that's where the problem is. It keeps track of available GTT s=
pace with<br>
&gt;&gt;&gt; an atomic counter in amdgpu_gtt_mgr.available. It gets decreme=
nted in<br>
&gt;&gt;&gt; amdgpu_gtt_mgr_new and incremented in amdgpu_gtt_mgr_del. The =
trouble<br>
&gt;&gt;&gt; is, that TTM doesn't call the latter for ttm_mem_regs that don=
't have an<br>
&gt;&gt;&gt; mm_node:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct t=
tm_mem_reg<br>
&gt;&gt;&gt;&gt; *mem)<br>
&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct ttm_mem_type_manager *man =3D<br>
&gt;&gt;&gt;&gt; &amp;bo-&gt;bdev-&gt;man[mem-&gt;mem_type];<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(mem-&gt;mm_node)<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*man-&gt;func-&gt;put_node)(m=
an, mem);<br>
&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt; GTT BOs that don't have GART space allocated, don't hate an mm=
_node. So<br>
&gt;&gt;&gt; the amdgpu_gtt_mgr.available counter doesn't get incremented w=
hen an<br>
&gt;&gt;&gt; unmapped GTT BO is freed, and eventually runs out of space.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Now I know what the problem is, but I don't know how to fix it=
. Maybe a<br>
&gt;&gt;&gt; dummy-mm_node for unmapped GTT BOs, to trick TTM into calling =
our<br>
&gt;&gt;&gt; put_node callback? Or a change in TTM to call put_node uncondi=
tionally?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [&nbsp; 360.082552] [TTM] Failed to find memory space for buff=
er<br>
&gt;&gt;&gt; 0x00000000264c823c eviction<br>
&gt;&gt;&gt; [&nbsp; 360.090331] [TTM]&nbsp; No space for 00000000264c823c =
(16384 pages,<br>
&gt;&gt;&gt; 65536K, 64M)<br>
&gt;&gt;&gt; [&nbsp; 360.090334] [TTM]&nbsp;&nbsp;&nbsp; placement[0]=3D0x0=
0010002 (1)<br>
&gt;&gt;&gt; [&nbsp; 360.090336] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_ty=
pe: 1<br>
&gt;&gt;&gt; [&nbsp; 360.090337] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_ty=
pe: 1<br>
&gt;&gt;&gt; [&nbsp; 360.090339] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags:=
 0x0000000A<br>
&gt;&gt;&gt; [&nbsp; 360.090341] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_of=
fset: 0xFF00000000<br>
&gt;&gt;&gt; [&nbsp; 360.090342] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size: =
1048576<br>
&gt;&gt;&gt; [&nbsp; 360.090344] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; availa=
ble_caching: 0x00070000<br>
&gt;&gt;&gt; [&nbsp; 360.090346] [TTM]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defaul=
t_caching: 0x00010000<br>
&gt;&gt;&gt; [&nbsp; 360.090349] [TTM]&nbsp; 0x0000000000000400-0x000000000=
0000402: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090352] [TTM]&nbsp; 0x0000000000000402-0x000000000=
0000404: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090354] [TTM]&nbsp; 0x0000000000000404-0x000000000=
0000406: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090355] [TTM]&nbsp; 0x0000000000000406-0x000000000=
0000408: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090357] [TTM]&nbsp; 0x0000000000000408-0x000000000=
000040a: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090359] [TTM]&nbsp; 0x000000000000040a-0x000000000=
000040c: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090361] [TTM]&nbsp; 0x000000000000040c-0x000000000=
000040e: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090363] [TTM]&nbsp; 0x000000000000040e-0x000000000=
0000410: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090365] [TTM]&nbsp; 0x0000000000000410-0x000000000=
0000412: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090367] [TTM]&nbsp; 0x0000000000000412-0x000000000=
0000414: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090368] [TTM]&nbsp; 0x0000000000000414-0x000000000=
0000415: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090370] [TTM]&nbsp; 0x0000000000000415-0x000000000=
0000515: 256: used<br>
&gt;&gt;&gt; [&nbsp; 360.090372] [TTM]&nbsp; 0x0000000000000515-0x000000000=
0000516: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090374] [TTM]&nbsp; 0x0000000000000516-0x000000000=
0000517: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090376] [TTM]&nbsp; 0x0000000000000517-0x000000000=
0000518: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090378] [TTM]&nbsp; 0x0000000000000518-0x000000000=
0000519: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090379] [TTM]&nbsp; 0x0000000000000519-0x000000000=
000051a: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090381] [TTM]&nbsp; 0x000000000000051a-0x000000000=
000051b: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090383] [TTM]&nbsp; 0x000000000000051b-0x000000000=
000051c: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090385] [TTM]&nbsp; 0x000000000000051c-0x000000000=
000051d: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090387] [TTM]&nbsp; 0x000000000000051d-0x000000000=
000051f: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090389] [TTM]&nbsp; 0x000000000000051f-0x000000000=
0000521: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090391] [TTM]&nbsp; 0x0000000000000521-0x000000000=
0000522: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090392] [TTM]&nbsp; 0x0000000000000522-0x000000000=
0000523: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090394] [TTM]&nbsp; 0x0000000000000523-0x000000000=
0000524: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090396] [TTM]&nbsp; 0x0000000000000524-0x000000000=
0000525: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090398] [TTM]&nbsp; 0x0000000000000525-0x000000000=
0000625: 256: used<br>
&gt;&gt;&gt; [&nbsp; 360.090400] [TTM]&nbsp; 0x0000000000000625-0x000000000=
0000725: 256: used<br>
&gt;&gt;&gt; [&nbsp; 360.090402] [TTM]&nbsp; 0x0000000000000725-0x000000000=
0000727: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090404] [TTM]&nbsp; 0x0000000000000727-0x000000000=
00007c0: 153: used<br>
&gt;&gt;&gt; [&nbsp; 360.090406] [TTM]&nbsp; 0x00000000000007c0-0x000000000=
0000b8a: 970: used<br>
&gt;&gt;&gt; [&nbsp; 360.090407] [TTM]&nbsp; 0x0000000000000b8a-0x000000000=
0000b8b: 1: used<br>
&gt;&gt;&gt; [&nbsp; 360.090409] [TTM]&nbsp; 0x0000000000000b8b-0x000000000=
0000bcb: 64: used<br>
&gt;&gt;&gt; [&nbsp; 360.090411] [TTM]&nbsp; 0x0000000000000bcb-0x000000000=
0000bcd: 2: used<br>
&gt;&gt;&gt; [&nbsp; 360.090413] [TTM]&nbsp; 0x0000000000000bcd-0x000000000=
0040000: 259123:<br>
&gt;&gt;&gt; free<br>
&gt;&gt;&gt; [&nbsp; 360.090415] [TTM]&nbsp; total: 261120, used 1997 free =
259123<br>
&gt;&gt;&gt; [&nbsp; 360.090417] [TTM]&nbsp; man size:1048576 pages, gtt av=
ailable:14371 pages,<br>
&gt;&gt;&gt; usage:4039MB<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Calexander.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;amp;sd=
ata=3DLVRisNun0DYM%2F5dLthnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;amp;reserved=
=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;amp;sdata=3DLVRisNun0DY=
M%2F5dLthnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;amp;reserved=3D0</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;amp;sdata=3D=
LVRisNun0DYM%2F5dLthnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ce19192b295fc41a7fb4c08d828a168d4%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637304021017509156&amp;amp;sdata=3DLVRisNun0DYM%=
2F5dLthnxNiN0KgAq%2BAh5mXvnoYEjkR0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488ECEC85B60DAB3CBC33EBF77E0MN2PR12MB4488namp_--

--===============1601571711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1601571711==--
