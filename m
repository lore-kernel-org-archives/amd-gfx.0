Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B1BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 22:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B14B1125F6;
	Wed, 22 Jun 2022 22:26:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0840F112691
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 22:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6WSO+ODeicVqYD9Y6rlznkENIBLPga6QV9HZCVJql76P4A9UQ6dpwSFe0tGclwkxMSgZnqu+MmwyzADNXECUFqwrLNmX5/MiWjn/aqENOfter+UvzSCPLh79ARX2+u24vZKYgX0byfsHfvw8EL0R0uOS+uckX22pEoYRZzFEgmg9oGA1kB6iOwe5iEX97CeN4KOWlclxpkBTnNV7NMzu4RcJ9CtxeEqXQfW7ibEzr32vCQgUUbj3a+oWom+wWA7x93xrN6QKLPKyRmySDs0KBm5/o/fDzMyfa0qqZ1QW29VIFvQQAwNcXDM7BhEO3cJoavEqKPzPiBM97QcQH/t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrqC2HQLRFiDTjRDHbiy+sBUy1NL3oWSK5cpy+RRM2c=;
 b=mKrJe9X4R0mNW2jdQUNLCp/meETzy1Ymlih4baK9mYNRHITBkn73TqXygHpNzqihRsmYKHiQ0A4UyqqFH83330uGKuoSvtoSEKDwlMIrdAQNRbi1/VKmcTarGtoI+GkGVYb0yiwYWDlKVllVfjcs3AAN06Dh70SsEqUEks3xGknW6w0EMyo+e/fAl269oI+ZaLxLn4eUX1vvPRPhSsppt6l5vJepqi5tsZOGMNd0Ml0yqHLGzXqTsBOKfFb2EKbv7aliyY28uPL2MG80ayQStFX/WxnAT3Ch5La6x50rmP87bNkHe2kpgCXEs1SetbWJVX2t8RIJtpxwrukndu6z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrqC2HQLRFiDTjRDHbiy+sBUy1NL3oWSK5cpy+RRM2c=;
 b=HIKSyFz7Wh3PBSSXRIipAELM9sAVxXjb0cFDrGJbT2lidgAdC/59i3HsySuE5Q4jZJmhhuc3y+BHTC5aXbBXc5/Yr0xbx/YewuUHEr2yFlxFjUCz1irOZHAVxLHPnVRCaobf84h7WDHfbwHxX++EbQ4LfZLEcC/osRcMq+9eAec=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 22:26:47 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 22:26:47 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Thread-Topic: [PATCH v4 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Thread-Index: AQHYhk33Gqno5bayaUC0N6LI/eAqj61bxWeAgAA6MhA=
Date: Wed, 22 Jun 2022 22:26:47 +0000
Message-ID: <DM6PR12MB30679449A6970F98C94002658AB29@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220622153656.174491-2-Graham.Sider@amd.com>
 <7e0ec683-0004-2c40-bdd6-2a3f2c6e0852@amd.com>
In-Reply-To: <7e0ec683-0004-2c40-bdd6-2a3f2c6e0852@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-22T22:26:44Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b9b4341d-dfa7-45f7-83c8-d340fe660ef2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-22T22:26:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 23424550-684a-456b-8255-5e0897122765
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80abda73-0b8c-4575-ab0b-08da549e4b6f
x-ms-traffictypediagnostic: IA1PR12MB6017:EE_
x-microsoft-antispam-prvs: <IA1PR12MB6017E463569ADEED31B76A568AB29@IA1PR12MB6017.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWeq0NsUkLdjvYi0vB4bJ8NEy3TMdIAFRkElM1+dm2i7T8xoIPd3GgiMxqRPZRlkv80NaCBTTP/U97JlObtrecQYlgPKZexuRnoclDSmBCX2Xk1F2jzwOX6Eb8InYWL84QvpmxTdLCLBioqUNX6UXcJCqASHv0iU/dmpcNK7eaVrTRFaBBVYp5fPcWdF/Br+P+SvXWgw3YLA0FkJtU9HYQTmdQDmz0b/w2P5Hw3wcd9tm4EJ4ArlGAhTQVqh5ax+tiy++Xb7Pti5p8QY0lILDO2jEZ0XHprPj3vZXh/y+RODt+BeHTf14Trmy6wkfGHqvL+tezQc2Z50M14YAOYm2ajFV+7AWl6IkQ7WfAKYdCcF0JdCjG0cbHKa3tKU1Q5Sulv4bT2JSFb0REzgSBzr4+JKONfAm4f+wCd1VanXCVHm3oXjbiYCmh3PvwAwEHEOlNt9bxMcm9xzQTayi39R9fkYXJ9dWTqH3V8RE/Kn500Ju2+dKM4lJw/NeHPmR0m+VsXlo8Idao6B5TZ18mWXWyPoBcakhHJ5Be6C2+r9WDdDQyLH6wODUj6Hy/cG7IWQqkpNoA2hSol5zEnwBMEWrPW+V/VHbv5rH0m2ewRqz/K3GN2Cl7FR9giT2CA3V4Ox9JiEY5EiRGOeD5DbrcT9uN+gNIGDwXTLzIPQM+h20T8XgU2TjvffHz/sjedITPA2elXhHd5Vrf1TUAPQ/A/P5lKLuTSM4EsIfz249OKP/hM6sOKQ8m7UA29N9D1unWIEgQV8hfKuZmLLaRiDzmSOzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(54906003)(66946007)(110136005)(71200400001)(66446008)(316002)(26005)(76116006)(8936002)(38070700005)(86362001)(9686003)(64756008)(478600001)(5660300002)(66556008)(4326008)(6506007)(52536014)(66476007)(2906002)(8676002)(53546011)(33656002)(55016003)(38100700002)(7696005)(186003)(30864003)(122000001)(41300700001)(83380400001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTLiwJzvpNNoSbPBCSLX4JWdD+5ESi+/LhPh0IuPlkscMO4cciCyViT5ZDuN?=
 =?us-ascii?Q?EF+WOooBtTI5xuurm4WHo3pftfH4I+9arT2PbW6x5XZK0CwCdeqzuLXqGrLi?=
 =?us-ascii?Q?sz86mDdkPmMrTObQvTPAV2yJly5QxmeFZMIPWzrDQv/WJobL0ghSk5rxkZnK?=
 =?us-ascii?Q?WOyjrNT3DCp49cz3Z5/C/dfdv0eZz0XAg/riBDG4t8FBczV21K6MQdUk1rm1?=
 =?us-ascii?Q?QfC+FgkHsBzqmc3VXebx1X8cLkBb/DY/6hJTvHMznlP3XKncMx+H21/ltm6c?=
 =?us-ascii?Q?TXTzA11Kv/+tN1dGIpor9Z85DXU70SvRkwYxWTJnebLxMoDnaVZkaGYCw6lT?=
 =?us-ascii?Q?yeR/mVfxLgawmAeg8nQpvbJpREmi92my3Gqkze8yY/r1MoV/WVicSzgR5Fgw?=
 =?us-ascii?Q?jZQXv1e1laWIYV1fDRBAyI6l/I3xw8o6U+EWT27W3kUr3AmSOgocl9iTsHjE?=
 =?us-ascii?Q?7hUF0dtitRoD9BpVu+sUbKZyTa1YhO6A1Sg/fGr17pghX588vzs6VzomktM6?=
 =?us-ascii?Q?8S0Arnx6f1b7pL8KamU4bV8qIe1x9cpVoEfJBiApX0HozkxMFqx8mSRiqBnm?=
 =?us-ascii?Q?lFk0NX4+ult9L4I6Dq5nMl9qeIZ9boyYsS7+ZDmuCyQVPPfB8tb2bOvalcFY?=
 =?us-ascii?Q?jQHFhEjgDEpsFtw1CkU4WuxUBodJiIE46fQOsXw85J4cQ0u6iR/ugP8akLKb?=
 =?us-ascii?Q?TlyH82ACsjHzxW4zYuCxwrNw5JsQA0IGb7WqX1hYH995j5yuuCuZkXQoXh64?=
 =?us-ascii?Q?8PobYo6JhHiaEDz5kcBEAB+Fcde4bcRXo9ckKqQR0FeBB0KA02ozQ7YtsusB?=
 =?us-ascii?Q?dA0eVng7zBf43a9PGxtNhRok+jBxKkc6eux0Be7uZxfxvxKchuIuwrFPE+69?=
 =?us-ascii?Q?dHD0f8PN3H6FcVOPS8H3o1ZjgrQYcekFBcbISJEVeRiMcTQSlnR6T2Yvu9QB?=
 =?us-ascii?Q?9PCIZf3KOuT5guL9jKCCVWC/DarzjqG/3tuK2UbQpjmb2IOiNt0uJdKCgMwc?=
 =?us-ascii?Q?L4sunf0zxwFpnAbJOwIkBPKNSEvZXnhocWXm3xFKQxAB9etargOMQEKbtxHd?=
 =?us-ascii?Q?dbIBn7Gi31GCXXcrfJhZ6JgGE9CHWqUgZEeCWjZOc9gFO7EbHh2qjyr8C+qe?=
 =?us-ascii?Q?yc2nMXJKqHmh3xs2mmAokkAce5T3krrJ/yP8d8GKZxW7gUmdVz2VjUhEK1tj?=
 =?us-ascii?Q?vWO6mHOsonMl/W08Dw2cBGWjpWrnJZLUDusVECzCY2KSso6r+yTcn0qo4gfV?=
 =?us-ascii?Q?enlLhX4m/c0kd5cS2ItrhNAIh0pFCSuhDbmwLKBbu+BvJK/RZftX2DLHfxJN?=
 =?us-ascii?Q?gtvYx/2Dsx6yGotZFaO/rrCh6qcMzC/1z59PciVW3e9RD8LBvE/f4yP2ZnEN?=
 =?us-ascii?Q?XvOPdvzTyUOpSRQ6GNvQBJCiqEdsA5W4o7suZ+Z8lLqOtJaNKwePTFzS6W+a?=
 =?us-ascii?Q?mvDsI68JU9kl/ssawpnlTm4HdbKtK+HH5NtS9kPuFa49Nv1Fyiu05nW4zmTl?=
 =?us-ascii?Q?1GnLbKFgEStpodN+VKD8iZDw+gJwkrBdoRFc51MEZ1/hcMTIlaKXpveR93tS?=
 =?us-ascii?Q?BlG59g9pBg5MtVveinPJaL4V58Ck+D91eXhMDIn7/ibO3GwkfXJorTm3Y0KP?=
 =?us-ascii?Q?2fT07W1JbnXsqO6odph/5ZSi0QS1xVqDHS0hhgLAilIqinK/ZZB1q3dH9Wb6?=
 =?us-ascii?Q?dz6qYCxC7bHxtOUqD+xliDX6ZwmthCibJvgefV5AG50mYTkZFjXs+Auw4wvI?=
 =?us-ascii?Q?N9Q3DML5jQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB30679449A6970F98C94002658AB29DM6PR12MB3067namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80abda73-0b8c-4575-ab0b-08da549e4b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 22:26:47.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPOJuZOeMJ95hPiRwX2gJSro1/V1vwdqqQKmNt2M5k+DL98NJxrGozgssjzEgxNFV/rIHGou1aNY/tesh/W7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB30679449A6970F98C94002658AB29DM6PR12MB3067namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

>> On 2022-06-22 11:36, Graham Sider wrote:
>> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
>> GART for usermode queues in order to support oversubscription. In the
>> case that work is submitted to an unmapped queue, MES must have a GART
>> wptr address to determine whether the queue should be mapped.
>>
>> This change is accompanied with changes in MES and is applicable for
>> MES_API_VERSION >=3D 2.
>>
>> v3:
>> - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
>> - Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
>> - Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
>> - Cleanup/fix create_queue wptr_bo error handling
>> v4:
>> - Add MES version shift/mask defines to amdgpu_mes.h
>> - Change version check from MES_VERSION to MES_API_VERSION
>> - Add check in kfd_ioctl_create_queue before wptr bo pin/GART map to
>> ensure bo is a single page.
>>
>> Signed-off-by: Graham Sider Graham.Sider@amd.com<mailto:Graham.Sider@amd=
.com>
>> Acked-by: Alex Deucher alexander.deucher@amd.com<mailto:alexander.deuche=
r@amd.com>
>> Reviewed-by: Philip Yang Philip.Yang@amd.com<mailto:Philip.Yang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 48 +++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++
>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++-
>>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>>  .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++++---
>>  8 files changed, 127 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_amdkfd.h
>> index 648c031942e9..b25b41f50213 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -286,6 +286,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct =
kgd_mem *mem,
>>                                                                         =
       void **kptr, uint64_t *size);
>>  void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>
>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct=
 amdgpu_bo *bo);
>> +
>>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>                                                                         =
      struct dma_fence **ef);
>>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index afd6e6923189..615ac2895d62 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2148,6 +2148,54 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>>           return ret;
>>  }
>>
>> +/**
>> + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment refe=
rence count
>> + * @adev: Device to which allocated BO belongs
>> + * @bo: Buffer object to be mapped
>> + *
>> + * Before return, bo reference count is incremented. To release the ref=
erence and unpin/
>> + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>> + */
>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct=
 amdgpu_bo *bo)
>> +{
>> +       int ret;
>> +
>> +       ret =3D amdgpu_bo_reserve(bo, true);
>> +       if (ret) {
>> +                       pr_err("Failed to reserve bo. ret %d\n", ret);
>> +                       goto err_reserve_bo_failed;
>> +       }
>> +
>> +       ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>> +       if (ret) {
>> +                       pr_err("Failed to pin bo. ret %d\n", ret);
>> +                       goto err_pin_bo_failed;
>> +       }
>> +
>> +       ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
>> +       if (ret) {
>> +                       pr_err("Failed to bind bo to GART. ret %d\n", re=
t);
>> +                       goto err_map_bo_gart_failed;
>> +       }
>> +
>> +       amdgpu_amdkfd_remove_eviction_fence(
>> +                       bo, bo->kfd_bo->process_info->eviction_fence);
>> +
>> +       amdgpu_bo_unreserve(bo);
>> +
>> +       bo =3D amdgpu_bo_ref(bo);
>> +
>> +       return 0;
>> +
>> +err_map_bo_gart_failed:
>> +       amdgpu_bo_unpin(bo);
>> +err_pin_bo_failed:
>> +       amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +
>> +       return ret;
>> +}
>> +
>>  /** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kerne=
l CPU access
>>   *
>>   * @mem: Buffer object to be mapped for CPU access
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mes.h
>> index be4b51a5b5c7..137a2cc2e807 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -32,6 +32,13 @@
>>  #define AMDGPU_MES_MAX_GFX_PIPES            2
>>  #define AMDGPU_MES_MAX_SDMA_PIPES           2
>>
>> +#define AMDGPU_MES_API_VERSION_SHIFT              12
>> +#define AMDGPU_MES_FEAT_VERSION_SHIFT          24
>> +
>> +#define AMDGPU_MES_VERSION_MASK                      0x00000fff
>> +#define AMDGPU_MES_API_VERSION_MASK             0x00fff000
>> +#define AMDGPU_MES_FEAT_VERSION_MASK          0xff000000
>> +
>>  enum amdgpu_mes_priority_level {
>>           AMDGPU_MES_PRIORITY_LEVEL_LOW       =3D 0,
>>           AMDGPU_MES_PRIORITY_LEVEL_NORMAL    =3D 1,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_chardev.c
>> index 625e837f0119..a0246b4bae6b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -299,6 +299,7 @@ static int kfd_ioctl_create_queue(struct file *filep=
, struct kfd_process *p,
>>           struct kfd_process_device *pdd;
>>           struct queue_properties q_properties;
>>           uint32_t doorbell_offset_in_process =3D 0;
>> +       struct amdgpu_bo *wptr_bo =3D NULL;
>>
>>           memset(&q_properties, 0, sizeof(struct queue_properties));
>>
>> @@ -326,12 +327,49 @@ static int kfd_ioctl_create_queue(struct file *fil=
ep, struct kfd_process *p,
>>                           goto err_bind_process;
>>           }
>>
>> +       /* Starting with GFX11, wptr BOs must be mapped to GART for MES =
to determine work
>> +       * on unmapped queues for usermode queue oversubscription (no agg=
regated doorbell)
>> +       */
>> +       if (dev->shared_resources.enable_mes &&
>> +                                       ((dev->adev->mes.sched_version &=
 AMDGPU_MES_API_VERSION_MASK)
>> +                                       >> AMDGPU_MES_API_VERSION_SHIFT)=
 >=3D 2) {
>> +                       struct amdgpu_bo_va_mapping *wptr_mapping;
>> +                       struct amdgpu_vm *wptr_vm;
>> +
>> +                       wptr_vm =3D drm_priv_to_vm(pdd->drm_priv);
>> +                       err =3D amdgpu_bo_reserve(wptr_vm->root.bo, fals=
e);
>> +                       if (err)
>> +                                       goto err_wptr_map_gart;
>> +
>> +                       wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(
>> +                                                       wptr_vm, args->w=
rite_pointer_address >> PAGE_SHIFT);
>> +                       amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +                       if (!wptr_mapping) {
>> +                                       pr_err("Failed to lookup wptr bo=
\n");
>> +                                       err =3D -EINVAL;
>> +                                       goto err_wptr_map_gart;
>> +                       }
>> +
>> +                       wptr_bo =3D wptr_mapping->bo_va->base.bo;
>> +                       if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>> +                                       pr_err("Requested GART mapping f=
or wptr bo larger than one page\n");
>> +                                       err =3D -EINVAL;
>> +                                       goto err_wptr_map_gart;
>> +                       }
>> +
>> +                       err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->ad=
ev, wptr_bo);
>> +                       if (err) {
>> +                                       pr_err("Failed to map wptr bo to=
 GART\n");
>> +                                       goto err_wptr_map_gart;
>> +                       }
>> +       }
>> +
>>           pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>>                                           p->pasid,
>>                                           dev->id);
>>
>> -        err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties, &q=
ueue_id, NULL, NULL, NULL,
>> -                                        &doorbell_offset_in_process);
>> +       err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties, &qu=
eue_id, wptr_bo,
>> +                                       NULL, NULL, NULL, &doorbell_offs=
et_in_process);
>>           if (err !=3D 0)
>>                           goto err_create_queue;
>>
>> @@ -363,6 +401,9 @@ static int kfd_ioctl_create_queue(struct file *filep=
, struct kfd_process *p,
>>           return 0;
>>
>>  err_create_queue:
>> +       if (wptr_bo)
>> +                       amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>> +err_wptr_map_gart:
>>  err_bind_process:
>>  err_pdd:
>>           mutex_unlock(&p->mutex);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 213246a5b4e4..299927a4959b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -177,6 +177,7 @@ static int add_queue_mes(struct device_queue_manager=
 *dqm, struct queue *q,
>>           struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
>>           struct mes_add_queue_input queue_input;
>>           int r, queue_type;
>> +       uint64_t wptr_addr_off;
>>
>>           if (dqm->is_hws_hang)
>>                           return -EIO;
>> @@ -196,7 +197,13 @@ static int add_queue_mes(struct device_queue_manage=
r *dqm, struct queue *q,
>>                                                                         =
  AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>           queue_input.doorbell_offset =3D q->properties.doorbell_off;
>>           queue_input.mqd_addr =3D q->gart_mqd_addr;
>> -        queue_input.wptr_addr =3D (uint64_t)q->properties.write_ptr;
>> +
>> +       if (q->wptr_bo) {
>> +                       wptr_addr_off =3D (uint64_t)q->properties.write_=
ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
>> +                       queue_input.wptr_addr =3D ((uint64_t)q->wptr_bo-=
>tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
>> +       } else
>> +                       queue_input.wptr_addr =3D (uint64_t)q->propertie=
s.write_ptr;
>> +
>>           queue_input.paging =3D false;
>>           queue_input.tba_addr =3D qpd->tba_addr;
>>           queue_input.tma_addr =3D qpd->tma_addr;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> index 4e0387f591be..b8e14c2cc295 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, =
void *mqd,
>>           m->sdmax_rlcx_rb_base_hi =3D upper_32_bits(q->queue_address >>=
 8);
>>           m->sdmax_rlcx_rb_rptr_addr_lo =3D lower_32_bits((uint64_t)q->r=
ead_ptr);
>>           m->sdmax_rlcx_rb_rptr_addr_hi =3D upper_32_bits((uint64_t)q->r=
ead_ptr);
>> +       m->sdmax_rlcx_rb_wptr_poll_addr_lo =3D lower_32_bits((uint64_t)q=
->write_ptr);
>> +       m->sdmax_rlcx_rb_wptr_poll_addr_hi =3D upper_32_bits((uint64_t)q=
->write_ptr);
>>           m->sdmax_rlcx_doorbell_offset =3D
>>                           q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSE=
T__OFFSET__SHIFT;
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd=
/amdkfd/kfd_priv.h
>> index 91e5fa56f0a2..59ba50ce54d3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -570,6 +570,8 @@ struct queue {
>>           void *gang_ctx_bo;
>>           uint64_t gang_ctx_gpu_addr;
>>           void *gang_ctx_cpu_ptr;
>> +
>> +       struct amdgpu_bo *wptr_bo;
>>  };
>>
>>  enum KFD_MQD_TYPE {
>> @@ -1205,6 +1207,7 @@ int pqm_create_queue(struct process_queue_manager =
*pqm,
>>                                               struct file *f,
>>                                               struct queue_properties *p=
roperties,
>>                                               unsigned int *qid,
>> +                                           struct amdgpu_bo *wptr_bo,
>>                                               const struct kfd_criu_queu=
e_priv_data *q_data,
>>                                               const void *restore_mqd,
>>                                               const void *restore_ctl_st=
ack,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 99f2a6412201..8db58348de98 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -180,7 +180,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>>  static int init_user_queue(struct process_queue_manager *pqm,
>>                                                           struct kfd_dev=
 *dev, struct queue **q,
>>                                                           struct queue_p=
roperties *q_properties,
>> -                                                        struct file *f,=
 unsigned int qid)
>> +                                                       struct file *f, =
struct amdgpu_bo *wptr_bo,
>> +                                                       unsigned int qid=
)
>>  {
>>           int retval;
>>
>> @@ -210,6 +211,7 @@ static int init_user_queue(struct process_queue_mana=
ger *pqm,
>>                                           goto cleanup;
>>                           }
>>                           memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_G=
ANG_CTX_SIZE);
>> +                       (*q)->wptr_bo =3D wptr_bo;
>>           }
>>
>>           pr_debug("PQM After init queue");
>> @@ -226,6 +228,7 @@ int pqm_create_queue(struct process_queue_manager *p=
qm,
>>                                               struct file *f,
>>                                               struct queue_properties *p=
roperties,
>>                                               unsigned int *qid,
>> +                                           struct amdgpu_bo *wptr_bo,
>>                                               const struct kfd_criu_queu=
e_priv_data *q_data,
>>                                               const void *restore_mqd,
>>                                               const void *restore_ctl_st=
ack,
>> @@ -288,7 +291,7 @@ int pqm_create_queue(struct process_queue_manager *p=
qm,
>>                            * allocate_sdma_queue() in create_queue() has=
 the
>>                            * corresponding check logic.
>>                            */
>> -                        retval =3D init_user_queue(pqm, dev, &q, proper=
ties, f, *qid);
>> +                       retval =3D init_user_queue(pqm, dev, &q, propert=
ies, f, wptr_bo, *qid);
>>                           if (retval !=3D 0)
>>                                           goto err_create_queue;
>>                           pqn->q =3D q;
>> @@ -309,7 +312,7 @@ int pqm_create_queue(struct process_queue_manager *p=
qm,
>>                                           goto err_create_queue;
>>                           }
>>
>> -                        retval =3D init_user_queue(pqm, dev, &q, proper=
ties, f, *qid);
>> +                       retval =3D init_user_queue(pqm, dev, &q, propert=
ies, f, wptr_bo, *qid);
>>                           if (retval !=3D 0)
>>                                           goto err_create_queue;
>>                           pqn->q =3D q;
>> @@ -435,10 +438,15 @@ int pqm_destroy_queue(struct process_queue_manager=
 *pqm, unsigned int qid)
>>                                           pdd->qpd.num_gws =3D 0;
>>                           }
>>
>> -                        if (dev->shared_resources.enable_mes)
>> +                       if (dev->shared_resources.enable_mes) {
>>                                           amdgpu_amdkfd_free_gtt_mem(dev=
->adev,
>>                                                                         =
                     pqn->q->gang_ctx_bo);
>> -                        kfd_procfs_del_queue(pqn->q);
>> +                                       if (pqn->q->wptr_bo)
>> +                                                       amdgpu_amdkfd_fr=
ee_gtt_mem(dev->adev, pqn->q->wptr_bo);
>> +
>> +                                       kfd_procfs_del_queue(pqn->q);
>
> Seems rebase issue, kfd_procfs_del_queue(pqn->q) should be outside if (de=
v->shared_resources.enable_mes) {
>

Yeah this was a rebase issue. Fixed - thanks!

>> +
>> +                       }
>>                           uninit_queue(pqn->q);
>>           }
>>
>> @@ -844,7 +852,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>
>>           print_queue_properties(&qp);
>>
>> -        ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_i=
d, q_data, mqd, ctl_stack,
>> +       ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id=
, NULL, q_data, mqd, ctl_stack,
>
> CRIU restore user queues should create struct queue wptr_bo GART mapping =
based on MES API version.
> Regards,
> Philip
>

As discussed offline since this is somewhat separated this will be modified=
 in a future patch.

Best,
Graham

>>
>>                                                           NULL);
>>           if (ret) {
>>                           pr_err("Failed to create new queue err:%d\n", =
ret);

--_000_DM6PR12MB30679449A6970F98C94002658AB29DM6PR12MB3067namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; On 2022-06-22 11:36, Graham Sider wrote:<o:=
p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Starting with GFX11, MES requires wptr BOs =
to be GTT allocated/mapped to<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; GART for usermode queues in order to suppor=
t oversubscription. In the<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; case that work is submitted to an unmapped =
queue, MES must have a GART<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; wptr address to determine whether the queue=
 should be mapped.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; This change is accompanied with changes in =
MES and is applicable for<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; MES_API_VERSION &gt;=3D 2.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; v3:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Use amdgpu_vm_bo_lookup_mapping for wptr_=
bo mapping lookup<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Move wptr_bo refcount increment to amdgpu=
_amdkfd_map_gtt_bo_to_gart<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Remove list_del_init from amdgpu_amdkfd_m=
ap_gtt_bo_to_gart<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Cleanup/fix create_queue wptr_bo error ha=
ndling<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; v4:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Add MES version shift/mask defines to amd=
gpu_mes.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Change version check from MES_VERSION to =
MES_API_VERSION<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; - Add check in kfd_ioctl_create_queue befor=
e wptr bo pin/GART map to<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; ensure bo is a single page.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Signed-off-by: Graham Sider <a href=3D"mail=
to:Graham.Sider@amd.com">
Graham.Sider@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Acked-by: Alex Deucher <a href=3D"mailto:al=
exander.deucher@amd.com">
alexander.deucher@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Reviewed-by: Philip Yang <a href=3D"mailto:=
Philip.Yang@amd.com">
Philip.Yang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; ---<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_=
gpuvm.c&nbsp; | 48 +++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes=
.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_charde=
v.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 45 ++++++++++++++++-<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_m=
anager.c |&nbsp; 9 +++-<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manage=
r_v11.c &nbsp;|&nbsp; 2 +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++<o:p></o:p></p=
>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; .../amd/amdkfd/kfd_process_queue_mana=
ger.c&nbsp;&nbsp;&nbsp; | 20 +++++---<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; 8 files changed, 127 insertions(+), 9=
 deletions(-)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 648c031942e9..b25b41f50213 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -286,6 +286,8 @@ int amdgpu_amdkfd_gpuvm=
_map_gtt_bo_to_kernel(struct kgd_mem *mem,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void **kptr, uint64_t *s=
ize);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; void amdgpu_amdkfd_gpuvm_unmap_gtt_bo=
_from_kernel(struct kgd_mem *mem);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +int amdgpu_amdkfd_map_gtt_bo_to_gart(struc=
t amdgpu_device *adev, struct amdgpu_bo *bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; int amdgpu_amdkfd_gpuvm_restore_proce=
ss_bos(void *process_info,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;struct dma_fence **ef);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; int amdgpu_amdkfd_gpuvm_get_vm_fault_=
info(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index afd6e6923189..615ac2895d62 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd_gpuvm.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amd=
kfd_gpuvm.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -2148,6 +2148,54 @@ int amdgpu_amdkfd_gp=
uvm_sync_memory(<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +/**<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map =
BO to GART and increment reference count<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + * @adev: Device to which allocated BO bel=
ongs<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + * @bo: Buffer object to be mapped<o:p></o=
:p></p>
<p class=3D"MsoNormal">&gt;&gt; + *<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + * Before return, bo reference count is in=
cremented. To release the reference and unpin/<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + * unmap the BO, call amdgpu_amdkfd_free_g=
tt_mem.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; + */<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +int amdgpu_amdkfd_map_gtt_bo_to_gart(struc=
t amdgpu_device *adev, struct amdgpu_bo *bo)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +{<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r=
et;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_bo_reserve(bo, true);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
et) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_err(&quot;Failed to reserve bo. ret %d\n&quot;, ret);<o:=
p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto err_reserve_bo_failed;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
et) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_err(&quot;Failed to pin bo. ret %d\n&quot;, ret);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto err_pin_bo_failed;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_ttm_alloc_gart(&amp;bo-&gt;tbo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
et) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_err(&quot;Failed to bind bo to GART. ret %d\n&quot;, ret=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto err_map_bo_gart_failed;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_amdkfd_remove_eviction_fence(<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bo, bo-&gt;kfd_bo-&gt;process_info-&gt;eviction_fence);<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bo_unreserve(bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo =
=3D amdgpu_bo_ref(bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +err_map_bo_gart_failed:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bo_unpin(bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +err_pin_bo_failed:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bo_unreserve(bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +err_reserve_bo_failed:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +}<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; /** amdgpu_amdkfd_gpuvm_map_gtt_bo_to=
_kernel() - Map a GTT BO for kernel CPU access<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp;&nbsp; * @mem: Buffer object to be map=
ped for CPU access<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index be4b51a5b5c7..137a2cc2e807 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes=
.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes=
.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -32,6 +32,13 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; #define AMDGPU_MES_MAX_GFX_PIPES&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; #define AMDGPU_MES_MAX_SDMA_PIPES&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +#define AMDGPU_MES_API_VERSION_SHIFT&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12=
<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +#define AMDGPU_MES_FEAT_VERSION_SHIFT&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +#define AMDGPU_MES_VERSION_MASK&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000fff<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +#define AMDGPU_MES_API_VERSION_MASK&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00fff00=
0<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +#define AMDGPU_MES_FEAT_VERSION_MASK&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xff000000<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; enum amdgpu_mes_priority_level {<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_LOW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 0,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_NORMAL&nbsp;&nbsp;&nbsp; =3D 1,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd=
_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 625e837f0119..a0246b4bae6b 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_charde=
v.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_charde=
v.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -299,6 +299,7 @@ static int kfd_ioctl_cr=
eate_queue(struct file *filep, struct kfd_process *p,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; struct kfd_process_device *pdd;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; struct queue_properties q_properties;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; uint32_t doorbell_offset_in_process =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_bo *wptr_bo =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; memset(&amp;q_properties, 0, sizeof(struct queue_properties));<=
o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -326,12 +327,49 @@ static int kfd_ioctl_=
create_queue(struct file *filep, struct kfd_process *p,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_bind_process;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* St=
arting with GFX11, wptr BOs must be mapped to GART for MES to determine wor=
k<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on =
unmapped queues for usermode queue oversubscription (no aggregated doorbell=
)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:=
p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (d=
ev-&gt;shared_resources.enable_mes &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((dev-&gt;adev-&gt;mes.sched_version &=
amp; AMDGPU_MES_API_VERSION_MASK)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; AMDGPU_MES_API_VERSION_SHIFT)=
 &gt;=3D 2) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *wptr_mapping;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_vm *wptr_vm;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wptr_vm =3D drm_priv_to_vm(pdd-&gt;drm_priv);<o:p></o:p></p=
>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; err =3D amdgpu_bo_reserve(wptr_vm-&gt;root.bo, false);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (err)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(<o:p></o:p></p=
>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_vm, args-&gt=
;write_pointer_address &gt;&gt; PAGE_SHIFT);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_bo_unreserve(wptr_vm-&gt;root.bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!wptr_mapping) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to lookup wptr bo\=
n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wptr_bo =3D wptr_mapping-&gt;bo_va-&gt;base.bo;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (wptr_bo-&gt;tbo.base.size &gt; PAGE_SIZE) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Requested GART mapping fo=
r wptr bo larger than one page\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev-&gt;adev, wptr=
_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (err) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to map wptr bo to =
GART\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_wptr_map_gart;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pr_debug(&quot;Creating queue for PASID 0x%x on gpu 0x%x\n&quot=
;,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid,<o:p></o:=
p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;id);<o:p></o:=
p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 err =3D pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &a=
mp;queue_id, NULL, NULL, NULL,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;doorbell_offset_in_process)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
=3D pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &amp;qu=
eue_id, wptr_bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL, &amp;doorbell_offset=
_in_process);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (err !=3D 0)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -363,6 +401,9 @@ static int kfd_ioctl_cr=
eate_queue(struct file *filep, struct kfd_process *p,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; err_create_queue:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (w=
ptr_bo)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, wptr_bo);<o:p></o:=
p></p>
<p class=3D"MsoNormal">&gt;&gt; +err_wptr_map_gart:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; err_bind_process:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; err_pdd:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd=
_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manag=
er.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 213246a5b4e4..299927a4959b 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device=
_queue_manager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device=
_queue_manager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -177,6 +177,7 @@ static int add_queue_me=
s(struct device_queue_manager *dqm, struct queue *q,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; struct mes_add_queue_input queue_input;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; int r, queue_type;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t wptr_addr_off;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (dqm-&gt;is_hws_hang)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -196,7 +197,13 @@ static int add_queue_m=
es(struct device_queue_manager *dqm, struct queue *q,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_NORMAL;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; queue_input.doorbell_offset =3D q-&gt;properties.doorbell_off;<=
o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; queue_input.mqd_addr =3D q-&gt;gart_mqd_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 queue_input.wptr_addr =3D (uint64_t)q-&gt;properties.write_ptr;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q=
-&gt;wptr_bo) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wptr_addr_off =3D (uint64_t)q-&gt;properties.write_ptr - (u=
int64_t)q-&gt;wptr_bo-&gt;kfd_bo-&gt;va;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; queue_input.wptr_addr =3D ((uint64_t)q-&gt;wptr_bo-&gt;tbo.=
resource-&gt;start &lt;&lt; PAGE_SHIFT) + wptr_addr_off;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; queue_input.wptr_addr =3D (uint64_t)q-&gt;properties.write_=
ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; queue_input.paging =3D false;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; queue_input.tba_addr =3D qpd-&gt;tba_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; queue_input.tma_addr =3D qpd-&gt;tma_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd=
_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 4e0387f591be..b8e14c2cc295 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_ma=
nager_v11.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_ma=
nager_v11.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -377,6 +377,8 @@ static void update_mqd_=
sdma(struct mqd_manager *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_base_hi =3D upper_32_bits(q-&gt;queue_addre=
ss &gt;&gt; 8);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_addr_lo =3D lower_32_bits((uint64_t)q-=
&gt;read_ptr);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m-&gt;sdmax_rlcx_rb_rptr_addr_hi =3D upper_32_bits((uint64_t)q-=
&gt;read_ptr);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_wptr_poll_addr_lo =3D lower_32_bits((uint64_t)q-&gt;write_pt=
r);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt=
;sdmax_rlcx_rb_wptr_poll_addr_hi =3D upper_32_bits((uint64_t)q-&gt;write_pt=
r);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0_D=
OORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd=
_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 91e5fa56f0a2..59ba50ce54d3 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h=
<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h=
<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -570,6 +570,8 @@ struct queue {<o:p></o:=
p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; void *gang_ctx_bo;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; uint64_t gang_ctx_gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; void *gang_ctx_cpu_ptr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_bo *wptr_bo;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; enum KFD_MQD_TYPE {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -1205,6 +1207,7 @@ int pqm_create_queue(=
struct process_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;struct file *f,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;struct queue_properties *properties,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;unsigned int *qid,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct amdgpu_bo *w=
ptr_bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const struct kfd_criu_queue_priv_data *q_data,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const void *restore_mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const void *restore_ctl_stack,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd=
_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_man=
ager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; index 99f2a6412201..8db58348de98 100644<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_proces=
s_queue_manager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_proces=
s_queue_manager.c<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -180,7 +180,8 @@ void pqm_uninit(struct =
process_queue_manager *pqm)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; static int init_user_queue(struct pro=
cess_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct kfd_dev *dev, struct queue **q,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct queue_properties *q_properties,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file=
 *f, unsigned int qid)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct file *f, s=
truct amdgpu_bo *wptr_bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int qid)=
<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; int retval;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -210,6 +211,7 @@ static int init_user_qu=
eue(struct process_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<o:p></o=
:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((*q)-&gt;gang_ctx_cpu_ptr, 0, AMDGP=
U_MES_GANG_CTX_SIZE);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (*q)-&gt;wptr_bo =3D wptr_bo;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pr_debug(&quot;PQM After init queue&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -226,6 +228,7 @@ int pqm_create_queue(st=
ruct process_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;struct file *f,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;struct queue_properties *properties,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;unsigned int *qid,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct amdgpu_bo *w=
ptr_bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const struct kfd_criu_queue_priv_data *q_data,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const void *restore_mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;const void *restore_ctl_stack,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -288,7 +291,7 @@ int pqm_create_queue(st=
ruct process_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* allocate_sdma_queue() in create_qu=
eue() has the<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* corresponding check logic.<o:p></o=
:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properti=
es, f, *qid);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properties, f,=
 wptr_bo, *qid);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q =3D q;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -309,7 +312,7 @@ int pqm_create_queue(st=
ruct process_queue_manager *pqm,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properti=
es, f, *qid);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properties, f,=
 wptr_bo, *qid);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q =3D q;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -435,10 +438,15 @@ int pqm_destroy_queue=
(struct process_queue_manager *pqm, unsigned int qid)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.num_gws =
=3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes)<o:p></o:p></=
p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gt=
t_mem(dev-&gt;adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;pqn-&gt;q-&gt;g=
ang_ctx_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q-&gt;wptr_bo)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_fre=
e_gtt_mem(dev-&gt;adev, pqn-&gt;q-&gt;wptr_bo);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; Seems rebase issue, kfd_procfs_del_queue(pqn-&g=
t;q) should be outside if (dev-&gt;shared_resources.enable_mes) {<o:p></o:p=
></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yeah this was a rebase issue. Fixed &#8211; thanks!<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(pqn-&gt;q);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; @@ -844,7 +852,7 @@ int kfd_criu_restore_qu=
eue(struct kfd_process *p,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; print_queue_properties(&amp;qp);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ret =3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp;=
queue_id, q_data, mqd, ctl_stack,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp;queue=
_id, NULL, q_data, mqd, ctl_stack,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; CRIU restore user queues should create struct q=
ueue wptr_bo GART mapping based on MES API version.<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; Philip<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As discussed offline since this is somewhat separate=
d this will be modified in a future patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best,<o:p></o:p></p>
<p class=3D"MsoNormal">Graham<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; <o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (ret) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to create new queue er=
r:%d\n&quot;, ret);<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB30679449A6970F98C94002658AB29DM6PR12MB3067namp_--
