Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B8C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3FB2076D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 19:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fx9Ey7h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FB2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBED6E1BA;
	Tue, 29 Sep 2020 19:02:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D326E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 19:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnjXhXlyuSbKdIjvQIlX96uVUkrPuzSMS7/rrvxLdv7hDX6dCsinxqxaRNfzbNEtInk+zTVm2ynKMCBm3FDpibZZUr9+3zqwpZ93cnkD0AGtmKhD6A0eb5Lh/UOLB+Zf2gnxuGZnpN9aea8TPr02G84ATiBo1wgo7u5md8mnsx+zkAGhv/E4rAUDV/bPYLTSc8A0wv5hUistSTqNdfm+m5zuhmx7uUfH81sBg1aLt0eZSP87ir/jFsq0encUDHH3u/0J6OR7hdlVUpqlx2U0YvkPz1eFPWCCaMR6bWei53BRrResADXRjKP0R+H+u5nTqGxk8B2vXb10eGyb5e+U2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e53Pxp2UhuHhhpIabFDjAgTRRDwA+ySL+3Yr8nJ1Xwk=;
 b=eJV7kO5JmMvNWfXpBLc9PsSZUOrL/chomANq7zDCC44Hx9Om7R1J10pLKHcs3Qc3/9qGm7Np2tQqJGU8ebBXGX+sHVvedTg1rntQc1FOIDdZPuTJA8sjj6/ZD/xpkGMbwe3+kGGn/Ef92xXLvCn0EuaC5gFcalYCrbZZmAMSL+2kiprylqcT9WIDcHbfIzTdllm1uvzBGy5GrNdUNgLA0Xj0typbNnuQKW3jgGQ0Zsdl/s0Luk1v53zcvkrKhXqhZyYeESNp0AzCIvFUaILHjlZa8WRhxjPVTZ+cJs9fCcDVe1dgpJgE3vM970PPe1AKuXTGEPugswthwO2kxa1e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e53Pxp2UhuHhhpIabFDjAgTRRDwA+ySL+3Yr8nJ1Xwk=;
 b=fx9Ey7h7YYvp7U5tw5NS8mM4aaf8YFbpBHYiGH0jlNi7btRFd3dh0oJanBEMsuPMzB+a5mZkVrpuHFHRWBMBnn95iSXxOOlHG+6H7hFdIHs0K5zd754xjLhUl8cs/jSlJdN4zu1qHQnWsFhtN9GPvzRgpZ9AEhjr9vhzoLPYWlY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 19:02:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 19:02:36 +0000
Subject: Re: [PATCH 36/45] drm/amdgpu: add TOC firmware support for apu (v2)
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-36-alexander.deucher@amd.com>
 <535ea0cc-67e5-a81f-47d5-87b51ee47a82@amd.com>
 <CADnq5_Op9sobQ18HDjQ9TKwcQdhGYQP28CbFQEVCcMLFMZhuyQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <fe68afee-d9c6-e320-882e-d8d2dd8aacca@amd.com>
Date: Tue, 29 Sep 2020 15:02:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <CADnq5_Op9sobQ18HDjQ9TKwcQdhGYQP28CbFQEVCcMLFMZhuyQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23 via Frontend Transport; Tue, 29 Sep 2020 19:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0570eaf-73b3-44f1-34ec-08d864aa3ac9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18673440BA7D5EC5AA7E4E4199320@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aX6u5We3ZZOcElA5GJW9UX9l8wAtNxZg6X1yBe90DxbXXhy9MXwdPqbUYLBwBeGkxMe36HvdDd7GUrXw/kcX7bbHE1TUlfWkKlr3X6LDmUSRFOj/rXC5E7bcDM41cLBDuaqvyD4zJEz32gGWOKshaFyVIgX20+k1vI0VhaV77wq+T2+NctCFnGBQnNbhXe2fQsXyBx0UKdFxSZslnjVDSQMybGujlWwCeqUF4mLsAh3SQto4mhS5ffFGpKpnGHG6kZ7xYbEJwZrpzBarC34XdDEBYf71Yb8Z6YS5WonZvoy5q9tXkiSOxCQTiTeorD2lWWCQp0vqxh51YYKvRdsrBF+E2kByHP1HFwjtyBv06ETKN9Yy+f2B3aU5W7CqND0cesEMgu9aMAwmsDGUDJ/sbssaTlKEl7vCA3dKHRI/3Gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(83380400001)(44832011)(478600001)(54906003)(52116002)(956004)(26005)(53546011)(6506007)(86362001)(66556008)(66476007)(186003)(2616005)(5660300002)(316002)(16526019)(31696002)(8936002)(4326008)(6916009)(2906002)(6512007)(31686004)(8676002)(6486002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8Tgim79yuwdRXxokVXw75NKbph6KmESD/intFLTsa069WC5lcK3ItyDXaq571b6y3BZmqkWNMCpyAQctwxL6DyYyUthCM6DBdA5Wu8bRmOsLd6VsLhw1OxUhQcPI0SkTcQDkZoUTYm49oxVlxkFtyPw5eo1tbH2cQsAZ3wSsZgLK99pwvXJ4qKuDBDiJ09lHMyNhu2oXmpC66YBcJhyXigS25S94t/trkXFH37cON8Xp1z6KIGVfKOLbltALXsouupaFGe7dgpNYHTL8lppEj7mGLbveqBnkVaXysG2yjps4BZJ1WLevUIexCKAOvKZ862mi+Hz6xx8NoK6TEX76aXdA/+fqHW1FXmlKKU2LFY14QqST/4BqpAKDL+Sll9IrZXsQSMdBSWrEDZu4ypRvURXNenthxAZ47lITxQoPLicihuhcfiNnUkj+WzLF/cXnFO38tUJ+vwEfZ82jsGtGVBPYOjnPsdT2ZRR/r4zn2XPW72yj4XKB1/k3fW+Crzym1MvzemVEjpWeWEkr5uFupg9rDYBKJNQYsrxGalgb8GuXv9eiwYakFl6WoSCqAuOUkom+GcBA6I6ZKt/mbv6Pvqi7Da/9+mYwbi2rd9K0rxLuSD3v/Iq9ZowsSLHGbyHV3dxM9O+guGeUgrPb5FGHYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0570eaf-73b3-44f1-34ec-08d864aa3ac9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 19:02:36.8306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jScL7T2PbqwiFvq2DCE44nzY9V6RNh09x+SUXG5jk3Hm+VMjLM+Ds7YE4Sjg6t2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-29 11:09 a.m., Alex Deucher wrote:
> On Mon, Sep 28, 2020 at 6:26 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> On 2020-09-25 4:10 p.m., Alex Deucher wrote:
>>> From: Huang Rui <ray.huang@amd.com>
>>>
>>> APU needs load toc firmware for gfx10 series on psp front door loading.
>>>
>>> v2: rebase against latest code
>>>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 ++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  7 +++++
>>>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 33 ++++++++++++++++-------
>>>  4 files changed, 77 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index bd0d14419841..26caa8d43483 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -325,6 +325,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>>>               fw_info->ver = adev->dm.dmcub_fw_version;
>>>               fw_info->feature = 0;
>>>               break;
>>> +     case AMDGPU_INFO_FW_TOC:
>>> +             fw_info->ver = adev->psp.toc_fw_version;
>>> +             fw_info->feature = adev->psp.toc_feature_version;
>>> +             break;
>>>       default:
>>>               return -EINVAL;
>>>       }
>>> @@ -1464,6 +1468,13 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
>>>       seq_printf(m, "DMCUB feature version: %u, firmware version: 0x%08x\n",
>>>                  fw_info.feature, fw_info.ver);
>>>
>>> +     /* TOC */
>>> +     query_fw.fw_type = AMDGPU_INFO_FW_TOC;
>>> +     ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
>>> +     if (ret)
>>> +             return ret;
>>> +     seq_printf(m, "TOC feature version: %u, firmware version: 0x%08x\n",
>>> +                fw_info.feature, fw_info.ver);
>>>
>>>       seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index 18be544d8c1e..c8cec7ab499d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -2415,6 +2415,42 @@ int psp_init_asd_microcode(struct psp_context *psp,
>>>       return err;
>>>  }
>>>
>>> +int psp_init_toc_microcode(struct psp_context *psp,
>>> +                        const char *chip_name)
>>> +{
>>> +     struct amdgpu_device *adev = psp->adev;
>>> +     char fw_name[30];
>>> +     const struct psp_firmware_header_v1_0 *toc_hdr;
>>> +     int err = 0;
>>> +
>>> +     if (!chip_name) {
>>> +             dev_err(adev->dev, "invalid chip name for toc microcode\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", chip_name);
>>> +     err = request_firmware(&adev->psp.toc_fw, fw_name, adev->dev);
>>> +     if (err)
>>> +             goto out;
>>> +
>>> +     err = amdgpu_ucode_validate(adev->psp.toc_fw);
>>> +     if (err)
>>> +             goto out;
>>> +
>>> +     toc_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.toc_fw->data;
>>> +     adev->psp.toc_fw_version = le32_to_cpu(toc_hdr->header.ucode_version);
>>> +     adev->psp.toc_feature_version = le32_to_cpu(toc_hdr->ucode_feature_version);
>>> +     adev->psp.toc_bin_size = le32_to_cpu(toc_hdr->header.ucode_size_bytes);
>>> +     adev->psp.toc_start_addr = (uint8_t *)toc_hdr +
>>> +                             le32_to_cpu(toc_hdr->header.ucode_array_offset_bytes);
>>> +     return 0;
>>> +out:
>>
>> I'd rather this label be "Err:".
>>
>> Regardless of whether there already is a variable "err",
>> (there is!), capitalizing goto labels is good practice, since
>> it distinguishes them from variables (which are all lowercase),
>> and macros (which are all caps). Plus, you also avoid conflict
>> with the eponymous variable.
>>
> 
> I see your point, but I find random caps in code hard to read.

They wouldn't be random. They're only the names of goto labels,
kind of like when chapters of books or sections of papers are
capitalized. I think it would be good and visually distinctive.

FWIW, I've picked this capitalization of goto labels only,
*from the Linux kernel.* I liked it and I think it makes sense.
I certainly didn't come up with it myself.

Regards,
Luben

> 
>>> +     dev_err(adev->dev, "fail to initialize toc microcode\n");
>>
>> That's a very misleading message. Please print this instead:
>>
>>         dev_err(adev->dev,
>>                 "Failed to load/validate firmware for %s\n",
>>                 fw_name);
>>
>> To make it clear what was being loaded and validated and failed.
>>
> 
> Updated.
> 
> Thanks,
> 
> Alex
> 
>> Regards,
>> Luben
>>
>>> +     release_firmware(adev->psp.toc_fw);
>>> +     adev->psp.toc_fw = NULL;
>>> +     return err;
>>> +}
>>> +
>>>  int psp_init_sos_microcode(struct psp_context *psp,
>>>                          const char *chip_name)
>>>  {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> index 919d2fb7427b..13f56618660a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> @@ -253,6 +253,11 @@ struct psp_context
>>>       uint32_t                        asd_ucode_size;
>>>       uint8_t                         *asd_start_addr;
>>>
>>> +     /* toc firmware */
>>> +     const struct firmware           *toc_fw;
>>> +     uint32_t                        toc_fw_version;
>>> +     uint32_t                        toc_feature_version;
>>> +
>>>       /* fence buffer */
>>>       struct amdgpu_bo                *fence_buf_bo;
>>>       uint64_t                        fence_buf_mc_addr;
>>> @@ -386,6 +391,8 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>>>                       int index);
>>>  int psp_init_asd_microcode(struct psp_context *psp,
>>>                          const char *chip_name);
>>> +int psp_init_toc_microcode(struct psp_context *psp,
>>> +                        const char *chip_name);
>>>  int psp_init_sos_microcode(struct psp_context *psp,
>>>                          const char *chip_name);
>>>  int psp_init_ta_microcode(struct psp_context *psp,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> index 6c5d9612abcb..f2d6b2518eee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>>> @@ -109,20 +109,16 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>>>               BUG();
>>>       }
>>>
>>> -     err = psp_init_sos_microcode(psp, chip_name);
>>> -     if (err)
>>> -             return err;
>>> -
>>> -     if (adev->asic_type != CHIP_SIENNA_CICHLID &&
>>> -         adev->asic_type != CHIP_NAVY_FLOUNDER) {
>>> -             err = psp_init_asd_microcode(psp, chip_name);
>>> -             if (err)
>>> -                     return err;
>>> -     }
>>>
>>>       switch (adev->asic_type) {
>>>       case CHIP_VEGA20:
>>>       case CHIP_ARCTURUS:
>>> +             err = psp_init_sos_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>> +             err = psp_init_asd_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>>               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
>>>               err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
>>>               if (err) {
>>> @@ -150,6 +146,12 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>>>       case CHIP_NAVI10:
>>>       case CHIP_NAVI14:
>>>       case CHIP_NAVI12:
>>> +             err = psp_init_sos_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>> +             err = psp_init_asd_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>>               if (amdgpu_sriov_vf(adev))
>>>                       break;
>>>               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
>>> @@ -180,10 +182,21 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>>>               break;
>>>       case CHIP_SIENNA_CICHLID:
>>>       case CHIP_NAVY_FLOUNDER:
>>> +             err = psp_init_sos_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>>               err = psp_init_ta_microcode(&adev->psp, chip_name);
>>>               if (err)
>>>                       return err;
>>>               break;
>>> +     case CHIP_VANGOGH:
>>> +             err = psp_init_asd_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>> +             err = psp_init_toc_microcode(psp, chip_name);
>>> +             if (err)
>>> +                     return err;
>>> +             break;
>>>       default:
>>>               BUG();
>>>       }
>>>
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
