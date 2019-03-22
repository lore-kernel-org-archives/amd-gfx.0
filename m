From: Meelis Roos <mroos@linux.ee>
Subject: Re: Radeon HD 7450 brightness oversaturated
Date: Fri, 22 Mar 2019 16:59:25 +0200
Message-ID: <44de44e9-8ecc-4707-2c49-384f6ce9efcb@linux.ee>
References: <6f3801ea-476f-6715-db9b-0eb188c5711d@linux.ee>
 <CADnq5_O-sFxVsbxouJBRYi=H+RCmc0==jB7XVTifvWm-+EQLnQ@mail.gmail.com>
 <e61ee046-92fc-4e3d-02fb-c53d5699e41d@linux.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e61ee046-92fc-4e3d-02fb-c53d5699e41d@linux.ee>
Content-Language: et-EE
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

>>> Kernels are 5.0 and 5.1-rc1.
>>
>> Is it just kernels 5.0 and 5.1?  There haven't really been any display
>> related changes to radeon in ages.  Possibly a duplicate of:
>> https://bugzilla.kernel.org/show_bug.cgi?id=198123
> 
> No, I just put the card in and tested with only the current kernels I had.
> I can get some older kernel and test with that if that is of any help.

Just tested Debianis 4.19.0-4 package (4.19.28) and it exhibits the same
symptoms.

Slight additional detail: chenaging between fbcon vt-s does not fix it,
only changing between fbcon and X fixes it.

-- 
Meelis Roos <mroos@linux.ee>
