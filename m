Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBBCCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C89210E8B0;
	Thu, 23 Oct 2025 07:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IvhIo3VN";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50C310E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:03:39 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso3649278f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131018; x=1761735818; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UAcv1Nols3roleR0UnO7S1t1INuxWwIFkcQJLb9Fwrc=;
 b=IvhIo3VNKuSu+elKK0QwNz0sn5IS/KFN5zerD4EL3pfLKB2beJkseljRsAXoOaE7ap
 srShbF1MRWQYkHoiLRFZM4p4UcEkPePnUKmCFcg8qrGGxCzQdSE7hSHTpg/Z+avRQb1Q
 ChQzTf6bC80qpg11D4vePpTM5ZVLVIrpIp1NDGCQcDWZjsa4cPWmW8rtNN1ReWWm+DbO
 zDJOC6L8d6bgM9OEIz4gOmTGHjOC9kJPhyBeQqs/JJfQrRHCx9Ih/GR5XcYbfWWQGaJ+
 9XoRxcukm2kSeVgBqGBRum9RSaPhg+04XwvfCyxbuNrUaEBhrySZPXmdcqIhyFn8DQBg
 x4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131018; x=1761735818;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UAcv1Nols3roleR0UnO7S1t1INuxWwIFkcQJLb9Fwrc=;
 b=JfKBY6h10QyWUTdTXDr6zpThnuAn/p7dHER6/h5J2BjzGbTKZ0PtbMMI2Nc5WJohuR
 wcYfk9n0pzauST4pNF3iYN8Yqtn4Eka/GtvdzrKb9ig/yqXUU+baQjuyL96KyIF7Xnvp
 EzePYwe+z5EWqZpcCPtk1rqIRchSOExTFFRE+xjEk127FoQzJ9Iru/jeaX2CnxFOvHR7
 X9hGJ5V+5HI0H0IrhPBNUMSDVsGQdxAHri7FcfCX7gtTXmodk2bCZ/1ZGRJdwbYWJhSy
 csH3DOglmcQmnDl8R/AYwL+gDU1Dmpa1xL08zLxyi9ZmzSTskG8FZYn8DnUTSQhktMny
 OKVA==
X-Gm-Message-State: AOJu0YwTX6di/msaqWWh+wmPecd0DqMzGGm6CnfnAnffss3i7f2hFpJZ
 ZF1shitJpHnSupyozZg5NNAaFFYlHCBzSSBW4opysdMlap94VxMgM0DKb+r2RnUayR/sx3FG4rX
 gBII8
X-Gm-Gg: ASbGncserTet6dl9SfYErYL4AIS+kaJXWUYbzXTLL9Tf3l8WY4RxGUN8H1cLDfN9Nds
 rDS/q2EU1d6xiJ9pw8sMFQnu3a5um7EI7AB7ocqx70Eh0RexDCiuezOOAcIASG395hH/AbJbmv3
 Wy10KR76MSnvYVaeIEKrSiA4XmJQM1E89guxPgxIqGmghQE1GI9zNCc9ia8yYf+SJQ1sadP/RWN
 7qy1biGuLQeT3PcNfMryACV1iOqe2j7bQMtEQkfTAy7teh2pVa6iCa7xY/tcTOY/w4cw7lsrigi
 8UDqMn1Ko42svOakLgkSD5flUr1PgcHzShBo4WVMs0yzl53pWD2vzbsxdAxhgCTVghuQjcANyOR
 Q22ogsLFuHVwFhiZwi9HJ6R0EbWKvRTkRszKlXhHyY0pNDI1BFIfzxBlxbY968nOLYHBzu9qi+Q
 HLA2/DbAPIA0UbaNO/
X-Google-Smtp-Source: AGHT+IGO8rcEntJrGuFmt8IrSanN96p05eBSdFPmlHIUoNSbp/dGN3a7biuE3ErGB9OA7/DGLaG/dQ==
X-Received: by 2002:a5d:64e8:0:b0:427:7b7:dbdc with SMTP id
 ffacd0b85a97d-42707b7dc04mr12260911f8f.24.1761131017893; 
 Wed, 22 Oct 2025 04:03:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-427ea5b3b45sm24894864f8f.11.2025.10.22.04.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:03:37 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:03:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: update the functions to use amdgpu version
 of hmm
Message-ID: <aPi6BuxP0SYlcFgu@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

Hello Sunil Khatri,

Commit 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu
version of hmm") from Oct 10, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:1767 svm_range_validate_and_map()
	warn: passing freed memory 'range' (line 1746)

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c
    1698         start = map_start << PAGE_SHIFT;
    1699         end = (map_last + 1) << PAGE_SHIFT;
    1700         for (addr = start; !r && addr < end; ) {
    1701                 struct amdgpu_hmm_range *range = NULL;
    1702                 unsigned long map_start_vma;
    1703                 unsigned long map_last_vma;
    1704                 struct vm_area_struct *vma;
    1705                 unsigned long next = 0;
    1706                 unsigned long offset;
    1707                 unsigned long npages;
    1708                 bool readonly;
    1709 
    1710                 vma = vma_lookup(mm, addr);
    1711                 if (vma) {
    1712                         readonly = !(vma->vm_flags & VM_WRITE);
    1713 
    1714                         next = min(vma->vm_end, end);
    1715                         npages = (next - addr) >> PAGE_SHIFT;
    1716                         /* HMM requires at least READ permissions. If provided with PROT_NONE,
    1717                          * unmap the memory. If it's not already mapped, this is a no-op
    1718                          * If PROT_WRITE is provided without READ, warn first then unmap
    1719                          */
    1720                         if (!(vma->vm_flags & VM_READ)) {
    1721                                 unsigned long e, s;
    1722 
    1723                                 svm_range_lock(prange);
    1724                                 if (vma->vm_flags & VM_WRITE)
    1725                                         pr_debug("VM_WRITE without VM_READ is not supported");
    1726                                 s = max(start, prange->start);
    1727                                 e = min(end, prange->last);
    1728                                 if (e >= s)
    1729                                         r = svm_range_unmap_from_gpus(prange, s, e,
    1730                                                        KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
    1731                                 svm_range_unlock(prange);
    1732                                 /* If unmap returns non-zero, we'll bail on the next for loop
    1733                                  * iteration, so just leave r and continue
    1734                                  */
    1735                                 addr = next;
    1736                                 continue;
    1737                         }
    1738 
    1739                         WRITE_ONCE(p->svms.faulting_task, current);
    1740                         range = amdgpu_hmm_range_alloc(NULL);
    1741                         r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
    1742                                                        readonly, owner,
    1743                                                        range);
    1744                         WRITE_ONCE(p->svms.faulting_task, NULL);
    1745                         if (r) {
    1746                                 amdgpu_hmm_range_free(range);
                                                               ^^^^^
Freed here.

    1747                                 pr_debug("failed %d to get svm range pages\n", r);
    1748                         }
    1749                 } else {
    1750                         r = -EFAULT;
    1751                 }
    1752 
    1753                 if (!r) {
    1754                         offset = (addr >> PAGE_SHIFT) - prange->start;
    1755                         r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
    1756                                               range->hmm_range.hmm_pfns);
    1757                         if (r)
    1758                                 pr_debug("failed %d to dma map range\n", r);
    1759                 }
    1760 
    1761                 svm_range_lock(prange);
    1762 
    1763                 /* Free backing memory of hmm_range if it was initialized
    1764                  * Overrride return value to TRY AGAIN only if prior returns
    1765                  * were successful
    1766                  */
--> 1767                 if (range && !amdgpu_hmm_range_valid(range) && !r) {
                                                              ^^^^^
Use after free

    1768                         pr_debug("hmm update the range, need validate again\n");
    1769                         r = -EAGAIN;
    1770                 }
    1771                 /* Free the hmm range */
    1772                 amdgpu_hmm_range_free(range);
                                               ^^^^^
Double free

    1773 
    1774 
    1775                 if (!r && !list_empty(&prange->child_list)) {
    1776                         pr_debug("range split by unmap in parallel, validate again\n");
    1777                         r = -EAGAIN;
    1778                 }
    1779 
    1780                 if (!r) {
    1781                         map_start_vma = max(map_start, prange->start + offset);
    1782                         map_last_vma = min(map_last, prange->start + offset + npages - 1);
    1783                         if (map_start_vma <= map_last_vma) {
    1784                                 offset = map_start_vma - prange->start;
    1785                                 npages = map_last_vma - map_start_vma + 1;
    1786                                 r = svm_range_map_to_gpus(prange, offset, npages, readonly,
    1787                                                           ctx->bitmap, wait, flush_tlb);
    1788                         }
    1789                 }
    1790 
    1791                 if (!r && next == end)
    1792                         prange->mapped_to_gpu = true;
    1793 
    1794                 svm_range_unlock(prange);
    1795 
    1796                 addr = next;
    1797         }
    1798 
    1799         svm_range_unreserve_bos(ctx);
    1800         if (!r)
    1801                 prange->validate_timestamp = ktime_get_boottime();
    1802 
    1803 free_ctx:
    1804         kfree(ctx);
    1805 
    1806         return r;
    1807 }

regards,
dan carpenter
