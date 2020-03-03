Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32377C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F395F2073D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Aufcg8uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD006E096;
	Tue,  3 Mar 2020 16:18:17 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F13A6E096
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 16:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD1bjtcj9AwNvj5pnYKsolHqluZNiLtyAfaHrfPSJZNb3WFpjHTC4qNGE0LOha9gTHRtUB7kLjuMvgMMpJAXVilFBz2+sd5MyJgXr7jfIVn3HhOf+R+0S5cQw/AGkPbXNkhbLV1X8sKnkDSo5cbOclDFxWW2bUNlYGbb6eI58ZcaEwlSXvShWQp6IJasDB9eopIi2h/SnzvItJSR4tfX7LAkPf3MwtFDYSl0vtdsRqbRGB5Yx0BlzUJRKhMp+GU0EtoDmZekJIWusK4/VeQKg4ZWzeuev5q3i/XpoWnOYyD/T/jFA3BXuZEBH09dN4da6Khx7P62p/ku+jgKipewUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpHWx/Vbwcq5Pf+TdnYZGDUGy13GOiwK3sGvdQxlXP0=;
 b=lElRKDN4oIXvQaMT6WHT0TlDX3fANn6cAC5aXKQ9srw7yEWWHWJvrnGL8DVNsIHumIjSL6AhX+PszDgmGhkncRWFmDO9E0qZtfvr12n8Sv6qk67R6lCbJ/JTTeom+7bGMeGJXre7X23/d4614JWHO/6SNH+dNV+cVwk1uC5COqWaPBPNcsvrL+KJOFVmyFAfPOd3KYH46JLZdLbwkoXT82mcus9cXwp80TL1zg+A/RL0wAt+yUM7rfZ0xsFM9gBHLBmL3VkBoFIYAvnNJkCb3vUzfAQshXp0IkLdmMouULpWmmrW4iYWBhzZhk/NwHOH1D9N6XYuPaILGzrfhOuEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpHWx/Vbwcq5Pf+TdnYZGDUGy13GOiwK3sGvdQxlXP0=;
 b=Aufcg8uQIDxVHa1/O/NdVKtN0pwHuLalWLnizuBRiyUspqjIwdbeOvuqGYtydhZSSUfrYELTHvN+ZiFdpcAzV2REgZMHFmHZYdCBpPw8BaMDmvkG5SPYixTj32dyEyKtAsbeca/OxFP922Ow5gZSTuiq5vnBBF2M/tvml79DaNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Tue, 3 Mar
 2020 16:18:10 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 16:18:10 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Add USBC PD FW load to PSP 11
To: Alex Deucher <alexdeucher@gmail.com>
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-3-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MajmWzO4ec+_yeUa+mkMbyJWQuGagwXaU+FpQAPtrmkg@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <38295ce6-da27-a848-1dd5-1f0f3e9d4b60@amd.com>
Date: Tue, 3 Mar 2020 11:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_MajmWzO4ec+_yeUa+mkMbyJWQuGagwXaU+FpQAPtrmkg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 16:18:09 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a70defc-eb89-4c88-55ee-08d7bf8e7740
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:|MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16008A870D93424799959D77EAE40@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(6916009)(6486002)(31696002)(2906002)(86362001)(54906003)(19627235002)(53546011)(5660300002)(36756003)(52116002)(66556008)(66946007)(31686004)(81166006)(16526019)(966005)(8676002)(26005)(956004)(16576012)(45080400002)(2616005)(4326008)(66476007)(186003)(478600001)(81156014)(316002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1600;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvBTKxyosfduR6m8BlvnDvvh+H8XqHCTRApcxGyQZpHAMAryydxY0Sv5fSlz6OGdfazPfZPb6/yJwC2iMuzcNEkwrvecJny96Knj3SIjFsV+12Jcuqm2NMmtIsjhWGZ1w1j+H9d3PGy0idg28gU7gWVb2N387ImSTvqarxn5guJPAP6Us7XNshQecNM0w3QWqxo1HWhHlxmAqk7O8gMXvCckuSt1rP8dz4C46SyxQYthYmWkNQ4ItvuahC2/fv4E9GS50kz7FCRjrGCVnIwRv2fS/idPLvexWcuvxTgEXS1MWJA1r0Bv3Mh3lL6xPGiHeUczVOolL0n9+M7jQrxNsRVQBQo+YrBP837SZl6dh0kBlOMw24ytz8Sq/zE9Db8vagPrQsHyYrGHNnTfqU3ccka75aTToK0a1nXwrAKQ63IgCtR81BTlSXNdJoLhKWtQX1ybX5hBO4fvu6zCWALziwDVRzZBYcljzycFQqIZk3s=
X-MS-Exchange-AntiSpam-MessageData: OAsE4v9supRM1XHYo+PogxXQyrKJUkX5/JWxmv48Ov7aQSMdQsw1u+OsHsw3MxLdr2LDBEjFdWOVLq1JCIgGq6fKNEXiDLb5Mx4Rai3fD7reTQKytwRn17vtvu1miFDHyaqyIJjxG/JQBwhBgFUTyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a70defc-eb89-4c88-55ee-08d7bf8e7740
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 16:18:10.6499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqqKIj23+XcS2DIYaZqk+8iiIueQYm/d/tMk8MhYXO/9nQu8jgrfPBPhVK+qGq0Y9OaqsMeKDnxR+rZ5VCGAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Abramov,
 Slava" <Slava.Abramov@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/2/20 4:30 PM, Alex Deucher wrote:
> On Mon, Mar 2, 2020 at 2:24 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> Add the programming sequence.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 76 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> index 8ab3bf3..621b99c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> @@ -65,6 +65,9 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
>>   /* memory training timeout define */
>>   #define MEM_TRAIN_SEND_MSG_TIMEOUT_US  3000000
>>
>> +/* USBC PD FW version retrieval command */
>> +#define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
>> +
> This probably belongs in psp_gfx_if.h.
>
>>   static int psp_v11_0_init_microcode(struct psp_context *psp)
>>   {
>>          struct amdgpu_device *adev = psp->adev;
>> @@ -1109,6 +1112,77 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>>                  WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>>   }
>>
>> +static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, dma_addr_t dma_addr)
>> +{
>> +       struct amdgpu_device *adev = psp->adev;
>> +       uint32_t reg_status;
>> +       int ret;
>> +
>> +       /* Write lower 32-bit address of the PD Controller FW */
>> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, lower_32_bits(dma_addr));
>> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +                            0x80000000, 0x80000000, false);
>> +       if (ret)
>> +               return ret;
>> +
>> +        // Fireup interrupt so PSP can pick up the lower address
> C style comments please.
>
>> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x800000);
>> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +                            0x80000000, 0x80000000, false);
>> +       if (ret)
>> +               return ret;
>> +
>> +       reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> +
>> +       if ((reg_status & 0xFFFF) != 0) {
>> +               DRM_ERROR("Lower address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>> +                               reg_status & 0xFFFF);
>> +               return -EIO;
>> +       }
>> +
>> +       /* Write upper 32-bit address of the PD Controller FW */
>> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, upper_32_bits(dma_addr));
>> +
>> +
>> +       ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +                            0x80000000, 0x80000000, false);
>> +       if (ret)
>> +               return ret;
>> +
>> +        // Fireup interrupt so PSP can pick up the upper address
> C style comments.
>
>> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, 0x4000000);
>> +
>> +       /* FW load takes long time */
>> +       while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +                                            0x80000000, 0x80000000, false))
>> +               msleep(1000);
>> +
> Are we actually waiting for the full loading here or just the ack of
> the command?
>
>> +       reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
>> +
>> +       if ((reg_status & 0xFFFF) != 0) {
>> +               DRM_ERROR("Upper address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %02x...\n",
>> +                               reg_status & 0xFFFF);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
>> +{
>> +       struct amdgpu_device *adev = psp->adev;
>> +
>> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
>> +
>> +       while(psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>> +                                    0x80000000, 0x80000000, false))
>> +               msleep(1);
>> +
>> +       *fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
>> +
>> +       return 0;
>> +}
> I think we need locking for mmMP0_SMN_C2PMSG_35/mmMP0_SMN_C2PMSG_36
> since they are the mailbox registers for communicating with the PSP.
> Maybe just a generic psp lock since I don't think we need fine grained
> locking for psp.
>
> Alex


I wonder why we don't lock in any other place we access them (e.g. 
psp_v11_0_memory_training_send_msg or psp_v11_0_bootloader_load_sos) ?

Andrey

>
>> +
>>   static const struct psp_funcs psp_v11_0_funcs = {
>>          .init_microcode = psp_v11_0_init_microcode,
>>          .bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
>> @@ -1133,6 +1207,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
>>          .mem_training = psp_v11_0_memory_training,
>>          .ring_get_wptr = psp_v11_0_ring_get_wptr,
>>          .ring_set_wptr = psp_v11_0_ring_set_wptr,
>> +       .load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
>> +       .read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
>>   };
>>
>>   void psp_v11_0_set_psp_funcs(struct psp_context *psp)
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf3c9cee87052401e07f508d7bef10174%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637187814630848721&amp;sdata=Mo9%2BR4Nrh0rPxZ7xJrBzHl71M6rWL7KcrgEWOne6yQE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
