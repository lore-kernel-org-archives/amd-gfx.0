From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: fix power state when port pm is unavailable (v2)
Date: Wed, 23 Nov 2016 13:58:52 -0500
Message-ID: <CADnq5_MAbY8tLHNcuu3A0cviSYKFTMR4C6QUbTVV_JrdEO2AoA@mail.gmail.com>
References: <1479923013-14627-1-git-send-email-alexander.deucher@amd.com> <20161123182802.GB18537@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161123182802.GB18537@al>
Sender: stable-owner@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Nov 23, 2016 at 1:34 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> On Wed, Nov 23, 2016 at 12:43:33PM -0500, Alex Deucher wrote:
>> From: Peter Wu <peter@lekensteyn.nl>
>>
>> When PCIe port PM is not enabled (system BIOS is pre-2015 or the
>> pcie_port_pm=off parameter is set), legacy ATPX PM should still be
>> marked as supported. Otherwise the GPU can fail to power on after
>> runtime suspend. This affected a Dell Inspiron 5548.
>>
>> Ideally the BIOS date in the PCI core is lowered to 2013 (the first year
>> where hybrid graphics platforms using power resources was introduced),
>> but that seems more risky at this point and would not solve the
>> pcie_port_pm=off issue.
>>
>> v2: agd: fix typo
>
> Oops, silly copy/paste error from my side (accidentally replaced
> is_hybrid instead of power_cntl). Good catch!
>
> Peter
>
> PS. mail server refused to accept mail due to '#' in Cc, need CC:
> <stable@...> # 4.8+ below.

Whoops.  fixed.  thanks.

Alex

>
>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98505
>> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org # 4.8
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
>> index 2fdcd04..4129b12 100644
>> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
>> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
>> @@ -34,6 +34,7 @@ struct radeon_atpx {
>>
>>  static struct radeon_atpx_priv {
>>       bool atpx_detected;
>> +     bool bridge_pm_usable;
>>       /* handle for device - and atpx */
>>       acpi_handle dhandle;
>>       struct radeon_atpx atpx;
>> @@ -203,7 +204,11 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
>>       atpx->is_hybrid = false;
>>       if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>>               printk("ATPX Hybrid Graphics\n");
>> -             atpx->functions.power_cntl = false;
>> +             /*
>> +              * Disable legacy PM methods only when pcie port PM is usable,
>> +              * otherwise the device might fail to power off or power on.
>> +              */
>> +             atpx->functions.power_cntl = !radeon_atpx_priv.bridge_pm_usable;
>>               atpx->is_hybrid = true;
>>       }
>>
>> @@ -474,6 +479,7 @@ static int radeon_atpx_power_state(enum vga_switcheroo_client_id id,
>>   */
>>  static bool radeon_atpx_pci_probe_handle(struct pci_dev *pdev)
>>  {
>> +     struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
>>       acpi_handle dhandle, atpx_handle;
>>       acpi_status status;
>>
>> @@ -487,6 +493,7 @@ static bool radeon_atpx_pci_probe_handle(struct pci_dev *pdev)
>>
>>       radeon_atpx_priv.dhandle = dhandle;
>>       radeon_atpx_priv.atpx.handle = atpx_handle;
>> +     radeon_atpx_priv.bridge_pm_usable = parent_pdev && parent_pdev->bridge_d3;
>>       return true;
>>  }
>>
>> --
>> 2.5.5
